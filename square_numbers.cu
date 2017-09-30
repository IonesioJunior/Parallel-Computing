#include <stdio.h>

__global__ void square_1d_vector(float * d_out , float * d_in)
{
	int idx = threadIdx.x;
	d_out[idx] = d_in[idx] * d_in[idx];
}


void call_1d_parallel_computing(void)
{
	const int ARRAY_SIZE = 32;
	const int ARRAY_BYTES = ARRAY_SIZE * sizeof(float);
	
	//Host mem arrays
	float h_1d_in[ARRAY_SIZE];
	float h_1d_out[ARRAY_SIZE];
	printf("Original Array: \n");
	for(int i = 0; i < ARRAY_SIZE;i++)
	{
		h_1d_in[i] = float(i);
		printf("%d " , i);
	}
	printf("\n");

	//Device mem arrays
	float * d_1d_in;
	float * d_1d_out;
	
	cudaMalloc((void **) &d_1d_in,ARRAY_BYTES);
	cudaMalloc((void **) &d_1d_out, ARRAY_BYTES);
	
	cudaMemcpy(d_1d_in,h_1d_in,ARRAY_BYTES,cudaMemcpyHostToDevice);
	
	square_1d_vector<<< 1, ARRAY_SIZE >>>(d_1d_out , d_1d_in);
	
	cudaMemcpy(h_1d_out,d_1d_out,ARRAY_BYTES,cudaMemcpyDeviceToHost);

	printf("Square Array : \n");
	for(int i = 0;i < ARRAY_SIZE; i++)
	{
		printf("%d ",int(h_1d_out[i]));
	}
	printf("\n");
	
	cudaFree(d_1d_in);
	cudaFree(d_1d_out);
}

void print_header(void)
{
	printf(" ============================================== \n");
	printf(" ===== PARALLEL PROGRAMMING (1D - VECTOR) ===== \n");
	printf(" ============================================== \n");
	printf("\n");
}

int main(int argc,char** argv)
{
	print_header();
	printf("Computing square of numbers in some array ... \n");	
	call_1d_parallel_computing();
	return 0;
}
