# This script converts Terraform 0.12 variables/outputs to something suitable for `terraform-docs`
# As of terraform-docs v0.6.0, HCL2 is not supported. This script is a *dirty hack* to get around it.
# https://github.com/segmentio/terraform-docs/
# https://github.com/segmentio/terraform-docs/issues/62

# Script was originally found here: https://github.com/cloudposse/build-harness/blob/master/bin/terraform-docs.awk

{
  if ( $0 ~ /\{/ ) {
    braceCnt++
  }

  if ( $0 ~ /\}/ ) {
    braceCnt--
  }


  # ----------------------------------------------------------------------------------------------
  # variable|output "..." {
  # ----------------------------------------------------------------------------------------------
  # [END] variable/output block
  if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt == 0) {
    if (braceCnt == 0 && blockCnt > 0) {
      blockCnt--
      print $0
    }
  }
  # [START] variable or output block started
  if ($0 ~ /^[[:space:]]*(variable|output)[[:space:]][[:space:]]*"(.*?)"/) {
    # Normalize the braceCnt and block (should be 1 now)
    braceCnt = 1
    blockCnt = 1
    # [CLOSE] "default" and "type" block
    blockDefaultCnt = 0
    blockTypeCnt = 0
    # Print variable|output line
    print $0
  }


  # ----------------------------------------------------------------------------------------------
  # default = ...
  # ----------------------------------------------------------------------------------------------
  # [END] multiline "default" continues/ends
  if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt > 0) {
      print $0
      # Count opening blocks
      blockDefaultCnt += gsub(/\(/, "")
      blockDefaultCnt += gsub(/\[/, "")
      blockDefaultCnt += gsub(/\{/, "")
      # Count closing blocks
      blockDefaultCnt -= gsub(/\)/, "")
      blockDefaultCnt -= gsub(/\]/, "")
      blockDefaultCnt -= gsub(/\}/, "")
  }
  # [START] multiline "default" statement started
  if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt == 0) {
    if ($0 ~ /^[[:space:]][[:space:]]*(default)[[:space:]][[:space:]]*=/) {
      if ($3 ~ "null") {
        print "  default = \"null\""
      } else {
        print $0
        # Count opening blocks
        blockDefaultCnt += gsub(/\(/, "")
        blockDefaultCnt += gsub(/\[/, "")
        blockDefaultCnt += gsub(/\{/, "")
        # Count closing blocks
        blockDefaultCnt -= gsub(/\)/, "")
        blockDefaultCnt -= gsub(/\]/, "")
        blockDefaultCnt -= gsub(/\}/, "")
      }
    }
  }


  # ----------------------------------------------------------------------------------------------
  # type  = ...
  # ----------------------------------------------------------------------------------------------
  # [END] multiline "type" continues/ends
  if (blockCnt > 0 && blockTypeCnt > 0 && blockDefaultCnt == 0) {
    # The following 'print $0' would print multiline type definitions
    #print $0
    # Count opening blocks
    blockTypeCnt += gsub(/\(/, "")
    blockTypeCnt += gsub(/\[/, "")
    blockTypeCnt += gsub(/\{/, "")
    # Count closing blocks
    blockTypeCnt -= gsub(/\)/, "")
    blockTypeCnt -= gsub(/\]/, "")
    blockTypeCnt -= gsub(/\}/, "")
  }
  # [START] multiline "type" statement started
  if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt == 0) {
    if ($0 ~ /^[[:space:]][[:space:]]*(type)[[:space:]][[:space:]]*=/ ) {
      if ($3 ~ "object") {
        print "  type = \"object\""
      } else {
        # Convert multiline stuff into single line
        if ($3 ~ /^[[:space:]]*list[[:space:]]*\([[:space:]]*$/) {
          type = "list"
        } else if ($3 ~ /^[[:space:]]*string[[:space:]]*\([[:space:]]*$/) {
          type = "string"
        } else if ($3 ~ /^[[:space:]]*map[[:space:]]*\([[:space:]]*$/) {
          type = "map"
        } else {
          type = $3
        }

        # legacy quoted types: "string", "list", and "map"
        if (type ~ /^[[:space:]]*"(.*?)"[[:space:]]*$/) {
          print "  type = " type
        } else {
          print "  type = \"" type "\""
        }
      }
      # Count opening blocks
      blockTypeCnt += gsub(/\(/, "")
      blockTypeCnt += gsub(/\[/, "")
      blockTypeCnt += gsub(/\{/, "")
      # Count closing blocks
      blockTypeCnt -= gsub(/\)/, "")
      blockTypeCnt -= gsub(/\]/, "")
      blockTypeCnt -= gsub(/\}/, "")
    }
  }


  # ----------------------------------------------------------------------------------------------
  # description = ...
  # ----------------------------------------------------------------------------------------------
  # [PRINT] single line "description"
  if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt == 0) {
    if ($0 ~ /^[[:space:]][[:space:]]*description[[:space:]][[:space:]]*=/) {
      print $0
    }
  }


  # ----------------------------------------------------------------------------------------------
  # value = ...
  # ----------------------------------------------------------------------------------------------
  ## [PRINT] single line "value"
  #if (blockCnt > 0 && blockTypeCnt == 0 && blockDefaultCnt == 0) {
  #  if ($0 ~ /^[[:space:]][[:space:]]*value[[:space:]][[:space:]]*=/) {
  #    print $0
  #  }
  #}


  # ----------------------------------------------------------------------------------------------
  # Newlines, comments, everything else
  # ----------------------------------------------------------------------------------------------
  #if (blockTypeCnt == 0 && blockDefaultCnt == 0) {
  # Comments with '#'
  if ($0 ~ /^[[:space:]]*#/) {
    print $0
  }
  # Comments with '//'
  if ($0 ~ /^[[:space:]]*\/\//) {
    print $0
  }
  # Newlines
  if ($0 ~ /^[[:space:]]*$/) {
    print $0
  }
  #}
}
