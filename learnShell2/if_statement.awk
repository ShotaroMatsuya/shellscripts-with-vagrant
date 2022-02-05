NR  < 31 {
  print NR ":" $0
  if (NR % 10 == 0) {
    print "------"
  } else if (NR % 5 == 0) {
    print "---"
  } else {
    print "-"
  }
}
