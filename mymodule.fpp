#! fypp for creating templated functions.
#! example usage: fypp mymodule.fpp mymodule.f90

#! Remember, python ranges are strictly less than, unlike fortran
#:set irange = range(1,4)
#:set jrange = range(1,6)

module mymodule


contains


  subroutine foo(i,j)
    implicit none
    integer,intent(in) :: i, j
    select case(j)
#:for j in jrange
    case (${j}$)
       select case(i)
    #:for i in irange
       case(${i}$)
          call foo_${i}$_${j}$()
    #:endfor
       end select
#:endfor
    end select

  end subroutine foo
    
#:for j in jrange  
#:for i in irange    
  subroutine foo_${i}$_${j}$()
    implicit none
    integer, parameter :: i=${i}$, j=${j}$
    ! The code goes here.
    #:include 'code_guts.f90'
  end subroutine foo_${i}$_${j}$
#:endfor
#:endfor

end module mymodule
