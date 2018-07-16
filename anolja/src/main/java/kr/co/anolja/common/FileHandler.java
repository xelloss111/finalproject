package kr.co.anolja.common;

import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletResponse;

public class FileHandler {
	public void fileViewer(String filePath, String fileName, HttpServletResponse res) throws Exception {
		String uploadPath = "c:/java-lec/upload";
		String path = filePath;
		String fName = fileName;
		
		File f = new File(uploadPath + path, fName);
		if(!f.isDirectory()) {
			f.mkdirs();
		}
	
		res.setHeader("Content-Type", "image/jpeg");

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
	
	// base64 문자열 디코딩 처리 후 파일로 저장
	public Object[] base64Decode(String id, String fileInfo) throws Exception {
		String base64Image = fileInfo.split(",")[1];
		byte[] imagebytes = javax.xml.bind.DatatypeConverter.parseBase64Binary(base64Image);
		
		BufferedImage img = ImageIO.read(new ByteArrayInputStream(imagebytes));
		
		String uploadPath = "c:/java-lec/upload";
		SimpleDateFormat sdf = new SimpleDateFormat("/yyyy/MM/dd/HH");	
		String detailPath = sdf.format(new Date());
		File dir = new File(uploadPath + detailPath);

		if (!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		File image = new File(uploadPath + detailPath, id + ".jpg");
		ImageIO.write(img, "jpg", image);
		
		File imageInfo = new File(uploadPath + detailPath, id + ".jpg");
		long fileSize = imageInfo.length();
		
		
		Object[] base64Info = {detailPath, id + ".jpg", fileSize};
		
		return base64Info;
	}
}
