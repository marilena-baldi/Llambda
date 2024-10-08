from typing import Optional
from fastapi import FastAPI
from mangum import Mangum
from llama_cpp import Llama

app = FastAPI()
handler=Mangum(app)

MODELPATH="/opt/modelfile.gguf"
llm = Llama(model_path=MODELPATH)

@app.get("/prompt")
async def prompt(
        text: str,
        max_tokens: Optional[int] = 100,
    ):

    messages=[
        {"role": "system", "content": "you are a helpful assistant."},
        {"role": "user", "content": text}
    ]

    try:
        output = llm.create_chat_completion(
            messages=messages,
            max_tokens=max_tokens,
            seed=42,
            repeat_penalty=1.1
        )

        result = output.get("choices", [{}])[0].get("message", {}).get("content", "")
        return {"message": str(result)}

    except Exception as e:
        return {"message": str(e)}
