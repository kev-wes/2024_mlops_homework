import os
import httpx

# Bypass proxy for local addresses
os.environ['NO_PROXY'] = '127.0.0.1,localhost'

def test_api_health():
    try:
        response = httpx.get("http://127.0.0.1:4200/api/health")
        response.raise_for_status()
        print("API Health Check Successful:", response.json())
    except httpx.HTTPStatusError as exc:
        print(f"HTTP error occurred: {exc.response.status_code} - {exc.response.text}")
    except httpx.RequestError as exc:
        print(f"Request error occurred: {str(exc)}")
    except Exception as exc:
        print(f"An unexpected error occurred: {str(exc)}")

if __name__ == "__main__":
    test_api_health()
