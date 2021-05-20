#!/bin/bash

key=$1

enc_key=$(java -jar /Repo_Ops/Scripts/refresh/components/encrypt/1.0.0/encrypt.jar AES encrypt ${key});

echo $enc_key
