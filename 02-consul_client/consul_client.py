import requests
import urllib3
import argparse
import os
import base64


def get_value(list_dict):
	return base64.b64decode(list_dict[0]["Value"]).decode("utf-8")


def consul_kv_get(consul_address, request_headers, request_params=None, key_path=None):
	if key_path:
		url = "{}{}{}".format(consul_address, "/v1/kv/", key_path)
	else:
		url = "{}{}".format(consul_address, "/v1/kv")

	try:
		response = requests.request("GET", url, headers=request_headers, params=request_params, verify=False)
	except Exception as e:
		print("Error extracting key(s): {}".format(e))
		return None

	if request_params:
		return response.json()
	else:
		return get_value(response.json())


def consul_kv_put():
	#put request json=data
	#data = {"value": value}
	return None


def consul_kv_delete(consul_address, request_headers, key_path):
	url = "{}{}{}".format(consul_address, "/v1/kv/", key_path)
	try:
		response = requests.request("DELETE", url, headers=request_headers, verify=False)
		return response.text
	except Exception as e:
		print("Error deleteting key: {}".format(e))
		return None


def main(args):
	consul_http_address = os.environ["CONSUL_HTTP_ADDR"]
	consul_http_token   = os.environ["CONSUL_HTTP_TOKEN"]

	headers = {"x-consul-token": consul_http_token}
	urllib3.disable_warnings()

	print("Listing existing com_acme keys...")
	keys = consul_kv_get(consul_address=consul_http_address, request_headers=headers, request_params={"keys":"true"}, key_path="customer/com_acme_")
	for key in keys:
		value = consul_kv_get(consul_address=consul_http_address, request_headers=headers, key_path=key)
		print("Key: {} \n  Value: {}".format(key,value))
	
	print("Dropping keys with even numbers...")
	for key in keys:
		customer_index = int(key.split("/")[1].split("_")[2])
		if customer_index % 2 != 0:
			print("Attempting to drop {}... Response: {}".format(key, consul_kv_delete(consul_address=consul_http_address, request_headers=headers, key_path=key)))


if __name__ == "__main__":
	parser = argparse.ArgumentParser()
	#parser.add_argument("--consul-http-address")
	#parser.add_argument("--consul-http-token")
	main(parser.parse_args())
