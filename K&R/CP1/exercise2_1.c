/* My OS is 64-bit Ubuntu 14.04 */

#include <stdio.h>
#include <limits.h>

int main()
{
  printf("Maximum value of type signed char:%d\n", SCHAR_MAX);
  printf("Minimum value of type signed char:%d\n", SCHAR_MIN);

  printf("Maximum value of type unsigned char:%u\n\n", UCHAR_MAX);
  
  printf("Maximum value of type signed short:%d\n", SHRT_MAX);
  printf("Minimum value of type signed short:%d\n", SHRT_MIN);

  printf("Maximum value of type unsigned short:%u\n\n", USHRT_MAX);

  printf("Maximum value of type signed int:%d\n", INT_MAX);
  printf("Minimum value of type signed int:%d\n", INT_MIN);

  printf("Maximum value of type unsigned int:%u\n\n", UINT_MAX);

  printf("Maximum value of type signed long:%ld\n", LONG_MAX);
  printf("Minimum value of type signed long:%ld\n", LONG_MIN);

  printf("Maximum value of type unsigned long:%lu\n\n", ULONG_MAX);

  return 0;
}



