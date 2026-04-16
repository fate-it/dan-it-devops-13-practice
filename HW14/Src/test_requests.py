import requests

BASE = "http://127.0.0.1:5000"
results = []


def log(title, response):
    text = f"{title}\n{response.status_code} -> {response.text}\n\n"
    print(text)
    results.append(text)


r = requests.get(f"{BASE}/students")
log("GET ALL", r)


students = [
    {"first_name": "Ivan", "last_name": "Ivanov", "age": 20},
    {"first_name": "Petr", "last_name": "Petrov", "age": 22},
    {"first_name": "Oleg", "last_name": "Sidorov", "age": 25},
]

for s in students:
    r = requests.post(f"{BASE}/students", json=s)
    log("POST", r)


r = requests.get(f"{BASE}/students")
log("GET ALL", r)


r = requests.patch(f"{BASE}/students/2", json={"age": 30})
log("PATCH ID=2", r)


r = requests.get(f"{BASE}/students/id/2")
log("GET ID=2", r)


r = requests.put(f"{BASE}/students/3", json={
    "first_name": "Updated",
    "last_name": "User",
    "age": 99
})
log("PUT ID=3", r)


r = requests.get(f"{BASE}/students/id/3")
log("GET ID=3", r)


r = requests.get(f"{BASE}/students")
log("GET ALL", r)


r = requests.delete(f"{BASE}/students/1")
log("DELETE ID=1", r)


r = requests.get(f"{BASE}/students")
log("GET ALL", r)


# save results
with open("results.txt", "w", encoding="utf-8") as f:
    f.writelines(results)