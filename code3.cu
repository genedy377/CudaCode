#include <stdio.h>
#include <bits/stdc++.h>

# define N 512

__global__ void add(int *a,int *b,int *c)
 {
    c[threadIdx.x] = a[threadIdx.x] + b[threadIdx.x];
 }

void random_ints (int *a, int N)
{
   int i;
   for (i = 0; i < N; ++i)
    a[i] = rand();
}
int main(void) {

    int *a, *b, *c;
    int*d_a, *d_b, *d_c;    
    int size = N * sizeof(int);

    cudaMalloc((void**)&d_a, size);
    cudaMalloc((void**)&d_b, size);
    cudaMalloc((void**)&d_c, size);

    a = (int*)malloc(size); 
   //  random_ints(a, N);
    b = (int*)malloc(size); 
   //  random_ints(b, N);
    c = (int*)malloc(size);

    cudaMemcpy(d_a, a, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, size, cudaMemcpyHostToDevice);

    add<<<1,N>>>(d_a, d_b, d_c);

    cudaMemcpy(c, d_c, size, cudaMemcpyDeviceToHost);
    printf("%d\n%d\n%d\n" , *c, *a,*b );

    free(a); free(b); free(c);
    cudaFree(d_a); cudaFree(d_b); cudaFree(d_c);
    return 0;
    }