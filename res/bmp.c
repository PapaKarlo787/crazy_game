#include <iostream>
#include <stdio.h>
#include <string>
#include <memory>
#include <cstring>

using namespace std;

#pragma pack(push, 1)
struct BMP {
	char head[2];
	int fileSize;
	int _res;
	int dataOffset;
	
	int structSize;
	int width;
	int height;
	short planes;
	short bitCount;
	int compression;
	int dataSize;
	int pi_h;
	int pi_v;
	int palSize;
	int palUsed;
};
#pragma pack(pop)

void convertPalete(char* pal, int size) {
	auto f = fopen("palete.pal", "wb");
	for (int i = 0; i < (size << 2); i += 4) {
		pal[i] >>= 2;
		pal[i+1] >>= 2;
		pal[i+2] >>= 2;
		fwrite(pal + i + 2, 1, 1, f);
		fwrite(pal + i + 1, 1, 1, f);
		fwrite(pal + i, 1, 1, f);
	}
	fclose(f);
}

void convertBMP(char* bmp, int h, int w, FILE* f) {
	fwrite(&w, 2, 1, f);
	fwrite(&h, 2, 1, f);
	int _w = (w + 3) / 4 * 4;
	for (int i = (h - 1) * _w; i != -_w; i -= _w) {
		fwrite(&bmp[i], w, 1, f);
	}
}


int main(int n, char** names) {
	if (n == 1) {
		cout << "usage " << names[0] << " filenames" << endl;
		return -1;
	}
	
	for (int i = 1; i < n; i++) {
		auto fi = fopen(names[i], "rb");
		memcpy(names[i] + strlen(names[i]) - 4, ".pmb", 4);
		auto fo = fopen(names[i], "wb");
		BMP header;
		
		
		fread(&header, sizeof(BMP), 1, fi);
		if (header.bitCount != 8) {
			cout << "wrong file format" << endl;
			return -1;
		}
		char* palete = (char*)malloc(4 * header.palSize);
		char* data = (char*)malloc(header.dataSize);
		fread(palete, 4, header.palSize, fi);
		fseek(fi, header.dataOffset, 0);
		cout << fread(data, 1, header.dataSize, fi) << endl;
		if (i == 1)
			convertPalete(palete, header.palSize);
		convertBMP(data, header.height, header.width, fo);
		free(palete);
		free(data);
		fclose(fi);
		fclose(fo);
	}
	return 0;
}
