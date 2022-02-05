## what is array

# BEGIN {
#   # rank1 = "Gold"
#   # rank2 = "Silver"
#   # rank3 = "Bronze"
#   # ranks[1] = "Gold"
#   # ranks[2] = "Silver"
#   # ranks[3] = "Bronze"
#   split("Gold Silver Bronze", ranks)
#   print ranks[1] # Gold
#   ranks[2] = "Plata"
#   print ranks[2] # Plata
#   exit
# }

## categorize

# BEGIN {
#   split("Gold Silver Bronze", ranks)
#   print "Available Ranks:"
#   # for (i = 1; i <= 3; i++) {
#   for (i = 1; i <= length(ranks); i++) {
#     print ranks[i]
#   }
#   print "------"
# }
NR < 4 {
  sum = getSum()
  rank = getRank(sum)
  printf "Name: %-10s Sum: %'10d Rank: %-10s\n", $3, sum, rank
}
# 関数を作成
function getSum() {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
	return sum
}

function getRank(sum){
  split("Gold Silver Bronze", ranks)

  if (sum > 1000) {
    rank = ranks[1]
  } else if (sum > 800) {
    rank = ranks[2]
  } else {
   rank = ranks[3]
  }
  return rank
}
