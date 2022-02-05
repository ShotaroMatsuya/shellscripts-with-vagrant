NR < 4 {
  sum = 0
  for (i = 4; i <= 7; i++) {
    if ($i < 100) {
      # continue
      break
    }
    sum += $i
  }
  printf "Name: %-10s Sum: %'10d\n", $3, sum
}
