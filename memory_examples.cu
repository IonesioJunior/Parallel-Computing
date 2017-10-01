#include <stdio.h>

#define ARRAY_SIZE 128
__global__ void avarage_list(float * value_in,float * value_out){
	//Local memory
	int index = threadIdx.x;
	float sum = 0.0;

	// Static shared var
	__shared__ float sh_arr[ARRAY_SIZE];
	
	//Shared mem  | global memory 
	sh_arr[index] = value_in[index];
	
	__syncthreads(); // Garante que todos os numeros foram copiados antes de começar a prox operaçao
	
	//shared memory operation
	for(int i = 0; i <= index;i++){
		sum += sh_arr[i];
	}
	
	// Global memory | local memory
	value_out[index] = sum / (index + 1);
}



int main(int argc,char** argv){
	const int BYTE_SIZE = ARRAY_SIZE * sizeof(float);
	
	//Host var
	float h_values_in[ARRAY_SIZE];
	float h_avarage_out[ARRAY_SIZE];
	
	printf("Array Values : \n");
	for(int i = 0 ; i < ARRAY_SIZE;i++){
		h_values_in[i] = float(i * 2);
		printf("%.2f " , h_values_in[i]);
	}
	printf("\n");
	
	
	//Device var
	float *d_values_in;
	float *d_avarage_out;
	cudaMalloc((void**) &d_values_in,BYTE_SIZE);
	cudaMemcpy(d_values_in,h_values_in,BYTE_SIZE,cudaMemcpyHostToDevice);
	cudaMalloc((void**) &d_avarage_out,BYTE_SIZE);
	
	avarage_list<<<1,ARRAY_SIZE>>>(d_values_in,d_avarage_out);
	
	cudaMemcpy(h_avarage_out,d_avarage_out,BYTE_SIZE,cudaMemcpyDeviceToHost);
		

	printf("Avarage Array: \n");	
	for(int i = 0 ; i < ARRAY_SIZE;i++){
		printf("%.2f ",h_avarage_out[i]);
	}
	printf("\n");

	cudaFree(d_values_in);
	cudaFree(d_avarage_out);
	return 0;
}
