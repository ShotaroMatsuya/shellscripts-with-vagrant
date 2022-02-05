NR < 4 {
  sum = 0
  i = 4
  while (i <= 7) {
    sum += $i
    i++
  }
  printf "Name: %-10s Sum: %'10d\n", $3, sum
}
