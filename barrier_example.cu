#include <stdio.h>

__global__ void shift_forward(int * value)
{
	int index = threadIdx.x;
	__shared__ int array[64];
	array[index] = threadIdx.x; 
	__syncthreads(); // Garantir que todos os valores foram armazenados antes de começar o shift
	if(index < 63)
	{
		int tmp = array[index + 1];
		__syncthreads(); // Salvar cada valor antes que o mesmo seja trocado por outra thread
		value[index] = tmp;
		__syncthreads();
	}
} 


int main(int argc,char ** argv)
{
	
	const int ARRAY_SIZE = 64;
	const int SIZE = ARRAY_SIZE  * sizeof(int);
	
	int * d_out;
	cudaMalloc((void **) &d_out,SIZE);
	
	shift_forward<<<1,64>>>(d_out);	
	
	int h_out[ARRAY_SIZE];
	cudaMemcpy(h_out,d_out,SIZE,cudaMemcpyDeviceToHost);

	for(int i = 0 ; i < ARRAY_SIZE;i++)
	{
		printf("%d ",h_out[i]);
	}
	printf("\n");
	return 0;
}
