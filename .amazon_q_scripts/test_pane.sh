#!/bin/bash

next_file="tidb-cloud/tidb-cloud-intro.md"
prompt=$(printf "You are Translation Agent. Read instructions at /.amazon_q_context/sub_agent.md and translate this file: %q. Save output to .amazon_q_result/%q. When done, say 'Ready for next translation task. Translation complete for %q'" "$next_file" "$next_file" "$next_file")
echo $prompt