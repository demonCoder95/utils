# This script tests the database by querying the API of the VoIP Monitor
# and getting bulks of CDRs.
# Author: Noor
# Date: 28 Feb, 2022

import argparse
import requests
import time

# the default endpoint of the API server
server_url = "http://192.168.10.126"
# the default offset
cdr_offset = 100000
# the default size
cdr_size = 10000
# the default number of iterations to perform
num_iterations = 1

# create the argument parser
parser = argparse.ArgumentParser(description="Database Testing for CDRs.")
# add the arguments
parser.add_argument(
    '--server_url',
    type=str,
    default=server_url,
    help="The URL of the API server"
)
parser.add_argument(
    "--cdr_offset",
    type=int,
    default=cdr_offset,
    help="The CDR-ID offset"
)
parser.add_argument(
    "--cdr_size",
    type=int,
    default=cdr_size,
    help="The number of CDR entries to retrieve"
)
parser.add_argument(
    "--num_iter",
    type=int,
    default=num_iterations,
    help="The number of iterations to run of the test"
)

# parse the arguments of the program
arguments = parser.parse_args()

# get the argument values (default values will be set if not provided on the CLI)
server_url = arguments.server_url
cdr_offset = arguments.cdr_offset
cdr_size = arguments.cdr_size
num_iterations = arguments.num_iter

# form the API endpoint using arguments
api_endpoint = f"/calls?offset={cdr_offset}&size={cdr_size}"

# perform all the test iterations
for i in range(num_iterations):
    start_time = time.time()
    try:
        requests.get(server_url + api_endpoint)
        # response += str(response_obj.json())
    except Exception as e:
        print(f"Error occured!\n{e}")
    end_time = time.time()

    # construct the test report
    report = "\n" + "~*"*10 + f"TEST REPORT #{i+1}" + "~*"*10 + "\n" + \
        f"Ran the query: {api_endpoint}\n" + \
        f"Retrieved number of CDRs: {cdr_size*num_iterations}\n" + \
        f"Took time: {(end_time - start_time):.2f} seconds\n" + \
        "~*"*27

    # print the test report
    print(report)
