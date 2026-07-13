from pydantic import BaseModel
from typing import List, Dict, Any

class EvaluationRequest(BaseModel):
    artifact_name: str
    content: str

class DecisionRationale(BaseModel):
    who: str
    what: str
    where: str
    when: str
    why: str

class TraceLogItem(BaseModel):
    step: int
    submodule: str
    assertion: str
    status: str
    evidence: str

class ArbitrationResult(BaseModel):
    verdict: str
    arbitration_timestamp: str
    evaluation_context: Dict[str, str]
    decision_rationale: DecisionRationale
    execution_trace_log: List[TraceLogItem]
