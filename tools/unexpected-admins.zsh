#!/bin/zsh
# SPDX-License-Identifier: MIT
# Copyright (c) 2026 Altiward
#
# Unexpected admins check: a free Jamf Pro extension attribute for macOS, from Altiward.
#
# Lists every local account that holds admin rights but isn't on your list of
# permanent admins (IT's managed or LAPS account, for example). Membership is
# checked with dseditgroup, so accounts made admin through a nested group count
# too, and hidden accounts (UID below 500) aren't skipped.
#
# Output, for Jamf Pro:
#   <result>None</result>
#   <result>jdoe (logged in), support2</result>
#
# "(logged in)" marks the person at the Mac. If they're elevated through
# SAP Privileges when inventory runs, they'll show up here until their rights
# end. This snapshot does not establish whether any listed rights are authorised.
#
# https://altiward.com/guides/find-unexpected-admins/

# Accounts that should always be admin. Separate names with spaces.
PERMANENT_ADMINS=(root)

# Optional: also read the list from a managed preference, so you can change it
# with a configuration profile instead of editing the script. Set the domain
# and key to match your profile, or leave the domain empty to skip it.
PREF_DOMAIN=""                 # e.g. "com.example.unexpected-admins"
PREF_KEY="PermanentAdmins"     # an array of account names

if [[ -n $PREF_DOMAIN ]]; then
  pref_file="/Library/Managed Preferences/${PREF_DOMAIN}.plist"
  if [[ -f $pref_file ]]; then
    i=0
    while name=$(/usr/libexec/PlistBuddy -c "Print :${PREF_KEY}:${i}" "$pref_file" 2>/dev/null); do
      PERMANENT_ADMINS+=("$name")
      (( i++ ))
    done
  fi
fi

console_user=$(/usr/bin/stat -f %Su /dev/console)

found=()
for account in $(/usr/bin/dscl . -list /Users); do
  # Skip macOS's own service accounts.
  case $account in
    _*|daemon|nobody) continue ;;
  esac
  (( ${PERMANENT_ADMINS[(Ie)$account]} )) && continue

  if /usr/sbin/dseditgroup -o checkmember -m "$account" admin >/dev/null 2>&1; then
    if [[ $account == "$console_user" ]]; then
      found+=("$account (logged in)")
    else
      found+=("$account")
    fi
  fi
done

if (( ${#found} == 0 )); then
  echo "<result>None</result>"
else
  echo "<result>${(j:, :)found}</result>"
fi
