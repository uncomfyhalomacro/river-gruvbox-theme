#!/usr/bin/env bash
tail -1 $HOME/ristate.log | jq '.["Tags-ChimeiInnoluxCorporation"][] | tonumber'
