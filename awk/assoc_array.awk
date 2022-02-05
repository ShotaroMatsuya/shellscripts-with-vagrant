{
  sum = getSum()
  total[$3] += sum
}
END {
  for (name in total) {
    printf "Name: %-10s Total: %'10d\n", name, total[name]
  }
}

function getSum() {
  sum = 0
  for (i = 4; i <= 7; i++) {
    sum += $i
  }
  return sum
}

function getRank(sum) {
  ranks["first"] = "Gold"
  ranks["second"] = "Silver"
  ranks["third"] = "Bronze"
  if (sum > 1000) {
    rank = ranks["first"]
  } else if (sum > 800) {
    rank = ranks["second"]
  } else {
    rank = ranks["third"]
  }
  return rank
}
