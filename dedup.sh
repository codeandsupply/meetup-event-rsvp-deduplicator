#!/bin/bash

echo "Ready your URLs with slashes at the end."
read -p "Meetup A URL: " urlA
read -p "Meetup B URL: " urlB

realurlA="$(echo $urlA | sed -e 's/www\./api\./g')rsvps"
realurlB="$(echo $urlB | sed -e 's/www\./api\./g')rsvps"

echo "A: $realurlA"
echo "B: $realurlB"

curl "$realurlA" > /tmp/dedup_A.json
curl "$realurlB" > /tmp/dedup_B.json

jq .[].member.id /tmp/dedup_A.json > /tmp/dedup_A.txt
jq .[].member.id /tmp/dedup_B.json > /tmp/dedup_B.txt

echo "A: $(wc -l /tmp/dedup_A.txt)"
echo "B: $(wc -l /tmp/dedup_B.txt)"

echo "Unique: $(cat /tmp/dedup_A.txt /tmp/dedup_B.txt | sort -nu | wc -l)"


