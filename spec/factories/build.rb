FactoryGirl.define do
  factory :build do
    id '608cb5cb-4468-44ca-b75c-7555f22cdf71'
    ssh_public_key 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbDbmJVN5Mvv84kw6C7JGqZZL20femScBvs6lNxTocOM1UQCf5l88j+pbth9w9wwNalicuuPAg2cJFEAYDNFl4FOaphY6mhnxL380G9z2kR1arOjwLmacioTevVp1j3j6qgjyWRY8ZCIwWhMswhrp3/fe6orswSNQuZFXfvTFj1bL6qWXE6IY63e5F4vpbRf+Kaf9nhVgvwOd155X+gejrhne3qMFNXXqLcbWxEFSiIXumvQCWPHT+d9Z/41TYbaIPh5mF7RAAq//0qMC7XQF+OLNYkRf4zK1E2nsU3Fu9j2//hYqoytpUqhJWxUA6CUJGJJwCPjw3eouzVvB5UyQd LintCI'
    ssh_private_key "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEA2w25iVTeTL7/OJMOguyRqmWS9tH3pknAb7OpTcU6HDjNVEAn\n+ZfPI/qW7YfcPcMDWpYnLrjwINnCRRAGAzRZeBTmqYWOpoZ8S9/NBvc9pEdWqzo8\nC5mnIqE3r1adY94+qoI8lkWPGQiMFoTLMIa6d/33uqK7MEjULmRV370xY9Wy+qll\nxOiGOt3uReL6W0X/imn/Z4VYL8DndeeV/oHo64Z3t6jBTV16i3G1sRBUoiF7pr0A\nljx0/nfWf+NU2G2iD4eZhe0QAKv/9KjAu10BfjizWJEX+MytRNp7FNxbvY9v/4WK\nqMraVKoSVsVAOglCRiScAj48N3qLs1bweVMkHQIDAQABAoIBAFkGo/AfcNVKDpnk\nklI9aRoSe/8Z6IdJlA8Rum4kCPDtWO2zwUtcGlBqCKryu1zSg+tt+PCxMs53EdBV\nqcvlm7ME85XT9NzS7XM8uqvpEcFRSPUADuU8BkQ5t1LoZcDv0xIjKhJ8pKKs6ZpB\nT/8h0mjv652Lg34lKy7LkmcDEi6bK7Cr+AwdKyMGjV+TVRRapoU+3r4UQwsuLWvt\nWCjCqOUp06VEZdhlNTp2H9lZhokslj9bRJllyZ0WKk6DSVBNUwtx2T6Z0zbmRqHv\nvEO/iWK6Ax0JOnclkRJOoBKCPyd4ty5iYN6umod7ivmFsHVLygNk64+zJR1CJMhY\niAEV+3UCgYEA9PwSCq6kbd60ODqaZ+GjOKwtnSyn17+LLyrA67/lBiOnvE1B0C+b\nWz76O9g5hr3tiNMxdJGT2JoiZagEexU7mgN3MAgGvXzXKzqkeKsOiCZr8WS8lC+n\n882iafXks83X/Apc9eyefrBrz0/QGNl4DvpMMt6g3H15fl4IHYMvvmcCgYEA5Ocr\n5yTJaaRRnSY3rbn8oph7alyXdlAxLXIx4XYNnxbZhkhn+B2G8FS1vFgF9/QvfpE2\nN50trkoimizoFsA4KQHC/sCyxzDItyjtzGiAtilVnbeLR9XyD4SU8DXPiBY9i41+\necsuhzMdvfTfR0cTSbLe6I+wNFitLEIQFkYdbtsCgYAn8RUL8s9SLnYZmMxl1W7k\nJYZGUuqGjW8m4ISVqzKu3o9RbxMk2y4sIUdxDF7MrhiVL0Gn7Lg7H14uTsd0PdD6\n2kfLZ/OZX0pBfQ0ls1XqMsF0mOT6EA8E++jX98Qy4IOvTw069zocE61wHmYiNwqQ\n/pP/0zZM3JQ7Wx9dmG7nTwKBgA+hRVssJOCkyrnbUTP4niqQFOVHW0RF54W95XAK\nupVhXwsPSKIligBBGIO60vWCY/fVfIlBn0vmXgR/Cn37NBqAt0rj55E4YIw5LDun\n6xoFKoZxcP4/up6ao/ze/8PAGQW9bKRuXkf3EpHU9aYNUWDX6OaiYRrB71k1TZnn\nwby/AoGAHAZDN+yeI4E0MFvTZCOVm4gtX6O7FQga5+F2U/JTdacyqk9AUEuxcuz9\nf2z+WsscDextxQp4cI7rbsZQcQfTDREo4aPkQk+30RWrqA/a3Q7VXNe3fVrWL4Rf\nQ7P4/+nQjri8gtm9N8jepybfBBwf4oVZI7R5NXrIxdxYXejXXBQ=\n-----END RSA PRIVATE KEY-----\n"
    pull_request{attributes_for(:pull_request)}

    skip_create
    initialize_with do
      Build.new(
        'id' => id,
        'ssh_public_key' => ssh_public_key,
        'ssh_private_key' => ssh_private_key,
        'pull_request' => pull_request.deep_stringify_keys
      )
    end
  end
end
