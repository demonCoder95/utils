# This script extracts the count of unique call-IDs from a given CSV
# that has been exported from wireshark as packet dissections.
# Date: March 18, 2022

filename=input("Enter filename of the CSV: ").strip()

def dedup_csv(filename):
    unique_call_ids = set()
    with open(filename, "r") as f:
        for each_line in f.readlines():
            unique_call_ids.add(each_line.split(",")[4])

    print(f"The number of unique Call-IDs in the CSV are: {len(unique_call_ids)}")


dedup_csv(filename)