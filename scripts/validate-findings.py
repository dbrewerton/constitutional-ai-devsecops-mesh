#!/usr/bin/env python3

import argparse
import json
import sys
from pathlib import Path

from jsonschema import Draft202012Validator, FormatChecker


def load_json(path: Path) -> dict:
    try:
        with path.open("r", encoding="utf-8") as file:
            return json.load(file)
    except FileNotFoundError:
        raise RuntimeError(f"File not found: {path}")
    except json.JSONDecodeError as error:
        raise RuntimeError(
            f"Invalid JSON in {path}: line {error.lineno}, "
            f"column {error.colno}: {error.msg}"
        )


def format_path(error_path) -> str:
    if not error_path:
        return "<root>"

    return ".".join(str(part) for part in error_path)


def validate_document(schema_path: Path, document_path: Path) -> bool:
    schema = load_json(schema_path)
    document = load_json(document_path)

    Draft202012Validator.check_schema(schema)

    validator = Draft202012Validator(
        schema,
        format_checker=FormatChecker(),
    )

    errors = sorted(
        validator.iter_errors(document),
        key=lambda error: list(error.absolute_path),
    )

    if errors:
        print(f"[FAIL] {document_path}")

        for error in errors:
            print(f"  - {format_path(error.absolute_path)}: {error.message}")

        return False

    print(f"[PASS] {document_path}")
    return True


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Validate mesh findings against the canonical JSON Schema."
    )
    parser.add_argument(
        "documents",
        nargs="+",
        type=Path,
        help="One or more finding JSON files to validate.",
    )
    parser.add_argument(
        "--schema",
        type=Path,
        default=Path("schemas/finding.schema.json"),
        help="Path to the finding schema.",
    )

    args = parser.parse_args()

    try:
        results = [
            validate_document(args.schema, document)
            for document in args.documents
        ]
    except RuntimeError as error:
        print(f"[ERROR] {error}", file=sys.stderr)
        return 2
    except Exception as error:
        print(f"[ERROR] Schema validation failed: {error}", file=sys.stderr)
        return 2

    return 0 if all(results) else 1


if __name__ == "__main__":
    sys.exit(main())