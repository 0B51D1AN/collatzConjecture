program Collatz

    implicit none
    integer :: argc, min, max, i, j, count, temp
    character(len=50) :: arg
    integer, dimension(:), allocatable :: top10Numbers
    integer, dimension(:, :), allocatable :: sequenceLengths


    ! Command-line argument count check
    call get_command_argument_count(argc)
    if (argc < 2) then
        print *, "Please provide a range (Smallest to Largest) to calculate the longest Collatz Sequences"
        stop
    endif

    

    ! Get command-line arguments for min and max
    do i = 1, 2
        call get_command_argument(i, arg)
        read(arg, *) temp
        if (i == 1) then
            min = temp
        else
            max = temp
        endif
    enddo

    print *, "Range: ", min, " -> ", max

    allocate(sequenceLengths(max - min + 1, 2))

    ! Calculate sequence lengths and store them
    do i = min, max
        
        sequenceLengths(i - min + 1, 1) = i
        sequenceLengths(i - min + 1, 2) = collatzSequence(i)
    enddo

    ! Sorting the sequence lengths array based on sequence lengths
    do i = 1, max - min
        do j = 1, max - min - i + 1
            if (sequenceLengths(j, 2) < sequenceLengths(j + 1, 2)) then
                call swap(sequenceLengths(j, :), sequenceLengths(j + 1, :))
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
        do j = 1, 10 - i
            if (top10Numbers(j) > top10Numbers(j + 1)) then
                temp = top10Numbers(j)
                top10Numbers(j) = top10Numbers(j + 1)
                top10Numbers(j + 1) = temp

                call swap(sequenceLengths(j, :), sequenceLengths(j + 1, :))
            endif
        enddo
    enddo

    ! Display top 10 sequences based on integer size
    print *, "Sorted based on integer size"
    do i = 10, 1, -1
        print *, top10Numbers(i), sequenceLengths(i, 2)
    enddo

contains

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


function collatzSequence(n) result(length)
    integer, intent(in) :: n
    integer :: length, t

    t = n
    length = 1 ! Initializing length as 1 since the number itself is included
    do while (t /= 1)
        if (mod(t, 2) == 0) then
            t = t / 2
        else
            t = 3 * t + 1
        endif
        length = length + 1
    end do
end function collatzSequence