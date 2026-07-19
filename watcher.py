import os
import sys
import time
import httpx
import json
import re
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

ROOT_DIR = Path(__file__).resolve().parent
WORKSPACE_PATH = (ROOT_DIR / "workspace").resolve()
API_URL = "http://localhost:8000/arbitrate"


def open_workspace_file(path: Path, mode: str):
    """Open a workspace file without following a final-component symlink."""
    flags_by_mode = {
        "r": os.O_RDONLY,
        "w": os.O_WRONLY | os.O_CREAT | os.O_TRUNC,
    }
    flags = flags_by_mode[mode] | getattr(os, "O_NOFOLLOW", 0)
    descriptor = os.open(path, flags, 0o600)
    return os.fdopen(descriptor, mode, encoding="utf-8", errors="ignore" if mode == "r" else None)


def resolve_workspace_input(source_path: Path) -> Path:
    """Resolve an event path and require a regular, non-symlink workspace child."""
    if source_path.is_symlink():
        raise ValueError("Symbolic links are not accepted.")

    resolved = source_path.resolve(strict=True)
    resolved.relative_to(WORKSPACE_PATH)
    if resolved.parent != WORKSPACE_PATH or not resolved.is_file():
        raise ValueError("Event path is not a direct workspace file.")
    return resolved

# Initialize native OS-level voice synthesis handles automatically
if sys.platform == "win32":
    import win32com.client
    import pythoncom
    speaker_available = True
else:
    speaker_available = False

def instant_local_speech(text_to_speak: str):
    """Bypasses all network routing to speak immediately on the host hardware thread."""
    if speaker_available and text_to_speak:
        try:
            pythoncom.CoInitialize()
            speaker = win32com.client.Dispatch("SAPI.SpVoice")
            # Setting Priority to 1 forces the Windows sound driver to prioritize this thread
            speaker.Priority = 1 
            speaker.Speak(text_to_speak)
        except Exception as err:
            print(f"[-] Native sound engine warning: {err}", flush=True)
        finally:
            pythoncom.CoUninitialize()

class UltraLowLatencyHandler(FileSystemEventHandler):
    def on_created(self, event):
        self.process_file(event)
    def on_modified(self, event):
        self.process_file(event)

    def process_file(self, event):
        if event.is_directory:
            return
        source_path = Path(event.src_path)
        try:
            file_path = resolve_workspace_input(source_path)
        except (OSError, RuntimeError, ValueError):
            return

        if file_path.suffix in [".json", ".wav", ".mp4"] or ".audit" in file_path.name:
            return

        file_name = file_path.name
        # Sub-100ms verification tick ensures the file stream handle has settled
        time.sleep(0.05) 
        if not file_path.exists():
            return

        try:
            with open_workspace_file(file_path, "r") as f:
                content = f.read()
            if not content.strip():
                return

            print(f"[+] Instant Interception engaged for: {file_name}", flush=True)

            # --- RAPID LOCAL INTERCEPTION LAYER (Sub-5ms Execution) ---
            # 1. Check for hardcoded credentials instantly
            if "password" in content.lower() and ("=" in content or ":" in content):
                print(f"[🔊] CRITICAL: Hardcoded credential rule matched locally! Intercepting pipeline...", flush=True)
                instant_local_speech(f"Security Alert! Hardcoded database credentials detected inside {file_name}. Build rejected.")
                return

            # 2. Check for dangerous root Docker containers instantly
            if file_name.lower() == "dockerfile":
                if "from" in content.lower() and not re.search(r"FROM\s+(python:|alpine:|ubuntu:|debian:|docker\.io/library/)", content, re.IGNORECASE):
                    print(f"[🔊] CRITICAL: Untrusted registry rule matched locally! Intercepting pipeline...", flush=True)
                    instant_local_speech("Infrastructure Failure! Unverified base image registry detected inside Dockerfile. Deployment blocked.")
                    return
                if "user root" in content.lower() or ("user" in content.lower() and "root" in content.lower()):
                    print(f"[🔊] CRITICAL: Root user rule matched locally! Intercepting pipeline...", flush=True)
                    instant_local_speech("Compliance Failure! Container is executing with root privileges inside Dockerfile. Build rejected.")
                    return

            # --- ASYNCHRONOUS DEEP ANALYSIS FALLBACK ---
            # If standard shallow checks pass, delegate to container mesh for semantic analysis
            print(f"[*] Shallow checks passed. Delegating to container mesh for semantic verification...", flush=True)
            custom_timeout = httpx.Timeout(120.0, connect=60.0)
            response = httpx.post(API_URL, json={"artifact_name": file_name, "content": content}, timeout=custom_timeout)
            
            if response.status_code == 200:
                audit_log = response.json()
                audit_output_path = file_path.with_name(f"{file_name}.audit.json")
                if audit_output_path.parent != WORKSPACE_PATH:
                    raise ValueError("Audit output path escapes the workspace.")
                with open_workspace_file(audit_output_path, "w") as out:
                    json.dump(audit_log, out, indent=2)
                    
                verdict = audit_log.get("verdict", "UNKNOWN")
                print(f"[→] Deep Scan Complete. Verdict for {file_name}: {verdict}", flush=True)
                
                if verdict == "REJECTED":
                    speech_text = audit_log.get("decision_rationale", {}).get("what", "")
                    instant_local_speech(speech_text)
            else:
                print(f"[!] Processing pipeline exception. Status Code: {response.status_code}", flush=True)
        except Exception as e:
            print(f"[!] System pipeline worker trace exception: {str(e)}", flush=True)

if __name__ == "__main__":
    if not WORKSPACE_PATH.exists():
        WORKSPACE_PATH.mkdir(parents=True, exist_ok=True)
    event_handler = UltraLowLatencyHandler()
    observer = Observer()
    observer.schedule(event_handler, path=str(WORKSPACE_PATH), recursive=False)
    observer.start()
    print(f"[*] Ultra-Low-Latency Constitutional Mesh Active. Path: {WORKSPACE_PATH}", flush=True)
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
