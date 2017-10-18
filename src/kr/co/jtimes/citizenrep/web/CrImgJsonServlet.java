package kr.co.jtimes.citizenrep.web;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.google.gson.Gson;

import kr.co.jtimes.citizenrep.vo.CrImgVo;

@WebServlet("/citizenrep/crimg.do")
@MultipartConfig
public class CrImgJsonServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		final String SAVED_DIRECTORY = getServletContext().getRealPath("/citizenrep/ctrepimg");
		
		Part part = req.getPart("file-upload");
		CrImgVo crImgVo = new CrImgVo();
		
		String filename = getFilename(part);
		String imgname = filename.substring(0, filename.lastIndexOf("."));
		
		String saveFileName = System.currentTimeMillis() + "_" + imgname;
		String item = part.getContentType();
		String fType = item.substring(item.indexOf("/")+1, item.length());
		if("jpeg".equals(fType)) fType = "jpg";
		String path = saveFileName + "." + fType;
		part.write(SAVED_DIRECTORY + "/" + path);
		
		res.setContentType("text/plain;charset=utf-8");
		PrintWriter pw = res.getWriter();
		
		Gson gson = new Gson();
		crImgVo.setFileName(imgname);
		crImgVo.setFilePath(path);
		
		String text = gson.toJson(crImgVo);
		pw.write(text);
		
	}
	private String getFilename(Part part){
		String contentDisposition = part.getHeader("content-disposition");
		String[] items = contentDisposition.split(";");
		for(String item : items){
			if(item.trim().startsWith("filename")){
				return  item.substring(item.indexOf("=")+2, item.length()-1);
			}
		}
		return null;
	}
}
