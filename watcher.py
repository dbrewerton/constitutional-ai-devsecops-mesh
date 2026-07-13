import os
import sys
import time
import httpx
import json
from pathlib import Path
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler
from playsound3 import playsound

ROOT_DIR = Path(__file__).resolve().parent
WORKSPACE_PATH = ROOT_DIR / "workspace"
API_URL = "http://localhost:8000/arbitrate"

class UniversalArtifactHandler(FileSystemEventHandler):
    def on_created(self, event):
        self.process_file(event)
    def on_modified(self, event):
        self.process_file(event)

    def process_file(self, event):
        if event.is_directory:
            return
        file_path = Path(event.src_path)
        
        if file_path.suffix in [".json", ".wav", ".mp4"] or ".audit" in file_path.name:
            return

        file_name = file_path.name
        time.sleep(0.5) 
        if not file_path.exists():
            return

        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
            if not content.strip():
                return
                
            print(f"[+] Cross-Platform Watcher engaged: {file_name}")
            response = httpx.post(API_URL, json={"artifact_name": file_name, "content": content}, timeout=45.0)
            
            if response.status_code == 200:
                audit_log = response.json()
                audit_output_path = file_path.with_name(f"{file_name}.audit.json")
                with open(audit_output_path, "w", encoding="utf-8") as out:
                    json.dump(audit_log, out, indent=2)
                    
                verdict = audit_log.get("verdict", "UNKNOWN")
                print(f"[→] Scan Complete. Verdict for {file_name}: {verdict}")
                
                # --- SOLID RE-VERIFICATION TRACKING LOOP ---
                local_wav_path = WORKSPACE_PATH / f"{file_name}.wav"
                
                print(f"[*] Waiting for container engine to finalize speech generation...")
                # Wait up to 15 seconds for the file to appear and stabilize on disk
                file_ready = False
                for _ in range(30):
                    if local_wav_path.exists() and local_wav_path.stat().st_size > 1000:
                        # Check if the file size has stopped growing (fully written)
                        initial_size = local_wav_path.stat().st_size
                        time.sleep(0.3)
                        if local_wav_path.stat().st_size == initial_size:
                            file_ready = True
                            break
                    time.sleep(0.5)
                
                if file_ready:
                    print(f"[🔊] Broadcasting vocalized decision ledger out loud...")
                    try:
                        # Force blocking mode to ensure the thread plays completely
                        playsound(str(local_wav_path), block=True)
                    except Exception as audio_err:
                        print(f"[-] Native audio play warning: {audio_err}")
                else:
                    print(f"[!] Audio file write timeout. File missing or incomplete.")
            else:
                print(f"[!] Processing pipeline exception. Status Code: {response.status_code}")
        except Exception as e:
            print(f"[!] System pipeline worker trace exception: {str(e)}")

if __name__ == "__main__":
    if not WORKSPACE_PATH.exists():
        WORKSPACE_PATH.mkdir(parents=True, exist_ok=True)
    event_handler = UniversalArtifactHandler()
    observer = Observer()
    observer.schedule(event_handler, path=str(WORKSPACE_PATH), recursive=False)
    observer.start()
    print(f"[*] Constitutional AI Mesh Active. Target Path: {WORKSPACE_PATH}")
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        observer.stop()
    observer.join()
