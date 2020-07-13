In Swift, types have size, stride, and alignment.




The concept of alignment in C and Swift is exactly the same.



Size and stride is more complicated. In Swift, stride is the distance between two elements in an array. The size of a type in Swift is the stride minus 减去 the tail padding.



<hr>


<hr>

C's concept of size corresponds to Swift's stride (not size!)

 C does not have an equivalent of Swift's size.


C 的 size， 就是 Swift 的 stride