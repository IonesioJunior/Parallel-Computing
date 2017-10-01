#include <stdio.h>

__global__ void add_2d_numbers(int *d_out,int *d_in)
{
	int row = blockIdx.y * blockDim.y + threadIdx.y;
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int index = row * col + row;
	if(index == 8){
		printf("Checkpoint!\n");	
	}
	d_out[index] = d_in[index];
}


void call_2d_parallel_computing(void)
{
	const int N_ROWS = 5;
	const int N_COLS = 5;
	const int BYTES_SIZE = N_ROWS * N_COLS * sizeof(int);

	// Define Host matrix
	int h_2d_in[N_ROWS][N_COLS];
	int h_2d_out[N_ROWS][N_COLS];
	for(int i = 0; i < N_ROWS;i++)
	{
		for(int j = 0; j < N_COLS;j++)
		{
			h_2d_in[i][j] = i + j;
			printf("%d ",i + j);
		}
		printf("\n");
	}
	printf("\n");

	// Define device matrix
	int * d_2d_in;
	int * d_2d_out;

	cudaMalloc((void **) &d_2d_in,BYTES_SIZE);
	cudaMalloc((void **) &d_2d_out,BYTES_SIZE);

	cudaMemcpy(d_2d_in,h_2d_in,BYTES_SIZE,cudaMemcpyHostToDevice);

	dim3 dimBlock(N_ROWS,N_COLS);
	dim3 dimGrid(1,1);

	add_2d_numbers<<<dimGrid,dimBlock>>>(d_2d_out,d_2d_in);

	cudaMemcpy(h_2d_out,d_2d_out,BYTES_SIZE,cudaMemcpyDeviceToHost);	

	printf("Result : \n" );
	for(int i = 0 ; i < N_ROWS;i++)
	{
		for(int j = 0 ; j < N_COLS;j++)
		{
			printf("%d ",h_2d_out[i][j]);
		}
		printf("\n");
	}
	printf("\n");

	cudaFree(d_2d_in);
	cudaFree(d_2d_out);
}


int main(int argc,char ** argv)
{
	call_2d_parallel_computing();
	return 0;
}
