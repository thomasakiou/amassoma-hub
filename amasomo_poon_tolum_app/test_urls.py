import urllib.request
prefixes = [
  "https://vmi2848672.contaboserver.net/amassoma/api/static",
  "https://vmi2848672.contaboserver.net/api/static",
  "https://vmi2848672.contaboserver.net/amassoma/static",
  "https://vmi2848672.contaboserver.net/static",
  "https://vmi2848672.contaboserver.net/amassoma/api",
  "https://vmi2848672.contaboserver.net/api",
]
path = "/uploads/audio/ebimi_nua_v1-a875-6ea73e6f1f143720.wav"
with open("test_url_output.txt", "w") as f:
  for p in prefixes:
    try:
      r = urllib.request.urlopen(p+path)
      if r.status == 200:
        f.write("SUCCESS: " + p + path + "\n")
    except Exception as e:
      f.write("FAILED: " + p + path + " - " + str(e) + "\n")
