program Collatz

    integer :: i, count, min, max
    character(len=50) :: arg
    integer, dimension(:, :), allocatable :: sequenceLengths
    integer, dimension(:), allocatable :: top10Numbers

    ! Command-line argument count check
   
        count = command_argument_count()
        
    if (count < 2) then
        print *, "Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences"
        stop
    endif

    ! Get command-line arguments for min and max
    do i = 1, 2
        call get_command_argument(i, arg)
        read(arg, *) count
        if (i == 1) then
            min = count
        else
            max = count
        endif
    enddo

    print *, "Range: ", min, " -> ", max

    allocate(sequenceLengths(max - min + 1, 2))

    ! Calculate sequence lengths and store them
    do i = min, max
        sequenceLengths(i - min + 1, 1) = i
        sequenceLengths(i - min + 1, 2) = collatzNum(i)
    enddo

    ! Sorting the sequence lengths array based on sequence lengths
    do i = 1, max - min
        do count = 1, max - min - i + 1
            if (sequenceLengths(count, 2) < sequenceLengths(count + 1, 2)) then
                call swap(sequenceLengths(count, :), sequenceLengths(count + 1, :))
            endif
        enddo
    enddo

    ! Display top 10 sequences based on length
    count = 1
    print *, "Sorted based on sequence length"
    do i = 1, size(sequenceLengths, 1)
        print *, sequenceLengths(i, 1), sequenceLengths(i, 2)
        count = count + 1
        if (count > 10) exit
    enddo

    ! Selecting and sorting the top 10 numbers by their numerical value
    allocate(top10Numbers(10))
    do i = 1, 10
        top10Numbers(i) = sequenceLengths(i, 1)
    enddo

    do i = 1, 9
        do count = 1, 10 - i
            if (top10Numbers(count) > top10Numbers(count + 1)) then
                min = top10Numbers(count)
                top10Numbers(count) = top10Numbers(count + 1)
                top10Numbers(count + 1) = min

                call swap(sequenceLengths(count, :), sequenceLengths(count + 1, :))
            endif
        enddo
    enddo

    ! Display top 10 sequences based on integer size
    print *, "Sorted based on integer size"
    do i = 10, 1, -1
        print *, top10Numbers(i), sequenceLengths(i, 2)
    enddo

contains
    recursive function collatzNum(n) result(length)
        integer, intent(in) :: n
        integer :: length

        if (n == 1) then
            length = 1
        else if (mod(n, 2) == 0) then
            length = 1 + collatzNum(n / 2)
        else
            length = 1 + collatzNum(3 * n + 1)
        endif
    end function collatzNum


    subroutine swap(a, b)
        integer, dimension(:), intent(inout) :: a, b
        integer :: temp

        temp = a(1)
        a(1) = b(1)
        b(1) = temp

        temp = a(2)
        a(2) = b(2)
        b(2) = temp
    end subroutine swap

end program Collatz

