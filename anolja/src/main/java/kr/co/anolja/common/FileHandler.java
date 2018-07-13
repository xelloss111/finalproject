package kr.co.anolja.common;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletResponse;

public class FileHandler {
	public void fileViewer(String filePath, String fileName, HttpServletResponse res) throws Exception {
		String uploadPath = "c:/java-lec/upload";
		String path = filePath;
		String fName = fileName;
		
		File f = new File(uploadPath + path, fName);
		
		res.setHeader("Content-Type", "image/jpg");

		FileInputStream fis = new FileInputStream(f);
		BufferedInputStream bis = new BufferedInputStream(fis);
		
		OutputStream out = res.getOutputStream();
		BufferedOutputStream bos = new BufferedOutputStream(out);
		
		while(true) {
			int ch = bis.read();
			if (ch == -1) break;
			bos.write(ch);
		}
		
		bis.close();
		fis.close();
		bos.close();
		out.close();
	}
	
	public void removeFile(String filePath, String fileName) throws Exception {
		String uploadPath = "c:/java-lec/upload";
		String path = filePath;
		String fName = fileName;
		
		File f = new File(uploadPath + path, fName);
		f.delete();
	}
}
