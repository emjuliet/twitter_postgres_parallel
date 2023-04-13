#!/bin/sh

files=$(find data/*)

echo '================================================================================'
echo 'load pg_denormalized'
echo '================================================================================'
time echo "$files" | parallel bash load_denormalized.sh

echo '================================================================================'
echo 'load pg_normalized'
echo '================================================================================'
echo "$files" | time parallel python3 -u load_tweets.py --db=postgresql://postgres:pass@localhost:1973/ --inputs

echo '================================================================================'
echo 'load pg_normalized_batch'
echo '================================================================================'
echo "$files" | time parallel python3 -u load_tweets_batch.py --db=postgresql://postgres:pass@localhost:2424/ --inputs
