#!/bin/bash

lambda_dir="../../backend/Serverless"
for lambda_path in "$lambda_dir"/*
do
  dotnet publish -c Release -r linux-x64 --self-contained false --output $lambda_path/bin/Release/net6.0/publish $lambda_path
done