package kr.co.mvc.admin.service;

import java.io.File;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.stereotype.Component;

import com.oreilly.servlet.MultipartRequest;

import kr.co.mvc.admin.vo.ImgFormVO;
import kr.co.mvc.admin.vo.ImgUploadVO;

@Component
public class ImgUploadService {

	/**
	 * �̹��� ���� �߰� ���μ��� (AJAX)
	 * @param request
	 * @return jsonString
	 */
	public String addImgFileProcess(HttpServletRequest request) {

		//temp������ ���� ���ε�
		File uploadPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		if(!uploadPath.exists()){ // ��ο� ���ε� ������ ������ ����
			uploadPath.mkdirs();
		}//end if
		
		int maxSize = 1024*1024*5; // 5 Mbyte
		MultipartRequest mr = null;
		JSONObject imgJson = null;
		try {
			mr = new MultipartRequest(request, uploadPath.getAbsolutePath(), maxSize, "UTF-8");
			
			String fileName = mr.getParameter("fileName");
			
			//main�̹����� ��ϵǾ����� ���ϸ� �����Ͽ� ����
			if(!("".equals(fileName)) && fileName != null){
				markMainImg(fileName);
			}//end if
			
			//temp ���Ͽ� �ִ� �̹��� ����Ʈ ��ȸ�Ͽ� JSONObject�� Return 
			List<ImgUploadVO> imgList = searchImgList();
			imgJson = new JSONObject();
			
			JSONArray ja = new JSONArray();
			JSONObject jo = new JSONObject();
			for(ImgUploadVO imgVO : imgList){
				jo = new JSONObject();
				jo.put("imgName", imgVO.getImgName());
				jo.put("imgLeng", imgVO.getImgLength() + " KB");
				ja.add(jo);
			}//end if	
			
			imgJson.put("imgData", ja);
			
		} catch (IOException e) {
			e.printStackTrace();
		}//end catch

		return imgJson.toJSONString();
	}//addImgFileProcess
	
	
	/**
	 * �̹��� ���� ���� ���μ��� (AJAX)
	 * @param imgName
	 * @return jsonString
	 */
	public String removeImgFileProcess(String imgName) {
		//Ư���̹��� ���� �� temp������ �ִ� �̹��� ����Ʈ ����ȸ
		removeTempImg(imgName);
		List<ImgUploadVO> imgList = searchImgList();
			
		//�ٽ� ��ȸ�� �̹��� ����Ʈ json�� �Ҵ�
		JSONObject imgJson = new JSONObject();
		
		JSONArray ja = new JSONArray();
		JSONObject jo = new JSONObject();
		for(ImgUploadVO imgVO : imgList){
			jo = new JSONObject();
			jo.put("imgName", imgVO.getImgName());
			jo.put("imgLeng", imgVO.getImgLength() + " KB");
			ja.add(jo);
		}//end for
		
		imgJson.put("imgData", ja);
		
		return imgJson.toJSONString();
	}//removeImgFileProcess
	
	
	/**
	 * �����̹��� ��Ͻ� ���ϸ��� mainImg�� �����Ͽ� �����ϴ� method
	 * @param fileName
	 */
	public void markMainImg(String fileName) {
		File selectedImgPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp/" + fileName);
		File mainImgPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp/"
				+ fileName.substring(0, fileName.indexOf(".")) + "_main" + fileName.substring(fileName.indexOf(".")));

		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		// ��ü ���� ����Ʈ ��ȸ �� main ���ԵǾ��ְų� ���� �̸����� ����Ǿ��ִ� ������ �ִٸ� ���� �� rename ó��
		File[] listFiles = temp.listFiles();
		
		for (File file : listFiles) {
			if (file.isFile() && file.getName().contains("_main")) {
				File delFile = new File(temp + "/" + file.getName());
				delFile.delete();
				break; 
			} // end if
		} // end for 
		selectedImgPath.renameTo(mainImgPath);
	}// markMainImg
	
	
	/**
	 * temp ���Ͽ� �����ϴ� �̹��� ��� ��ȸ
	 * @return List<UploadImgVO>
	 */
	public List<ImgUploadVO> searchImgList() {
		List<ImgUploadVO> list = new ArrayList<ImgUploadVO>();

		// 1. ���� ����Ʈ�� ������ ���� ����
		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		if(!temp.exists()) {
			temp.mkdirs();
		}
		
		// 2. �ش� ������ ��� ����, ���丮�� ����
		File[] listFiles = null;
		
		if(temp.listFiles() != null) { // ���� �ƴҶ� !
			listFiles = temp.listFiles();
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss");

			ImgUploadVO iuVO = null;
			for (File file : listFiles) {
				// 3. ���Ͽ� ���ؼ��� ������ ����
				if (file.isFile()) {
					// 4. list�� ���ϸ� �Ҵ�
					iuVO = new ImgUploadVO();
					iuVO.setImgName(file.getName());
					iuVO.setImgLength((int) ((file.length()) / 1024));
					iuVO.setLastModified(sdf.format(new Date(file.lastModified())));
					list.add(iuVO);
				} // end if
			} // end for

			// ��ϼ������ ����
			Collections.sort(list, new CompareDateAsc());
		}//end if
		return list;
	}// searchImgList

	/**
	 * searchImgList���� ��ȯ�� list�� ��ϼ������ �����ϴ� inner Class
	 * @author user
	 */
	public class CompareDateAsc implements Comparator<ImgUploadVO> {
		@Override
		public int compare(ImgUploadVO o1, ImgUploadVO o2) {
			return o1.getLastModified().compareTo(o2.getLastModified());
		}
	}//CompareDateAsc

	/**
	 * �����߰�/���� ���� �� temp�� �ִ� �������� roomImages������ �̵�
	 */
	public void moveImgtoRoomImg() {
		// �� ����
		File tempFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");
		// ������ ����
		File imgFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
		
		if(!tempFolder.exists()) {
			tempFolder.mkdirs();
		}//end if
		if(!imgFolder.exists()) {
			imgFolder.mkdirs();
		}//end if
		
		// �� ������ ���ϼ���ŭ ���� �迭 ����
		File[] fileList = tempFolder.listFiles();

		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {
			//���� ����
			for (File file : fileList) {
				File temp = new File(imgFolder.getAbsolutePath() + "/" + file.getName());

				fis = new FileInputStream(file);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File üũ
					fos.write(data, 0, byteCnt);
				} // end while
			} // end for
			fos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			//���� ����
			if (fis != null) {try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}}//end catch
			if (fos != null) {try {
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}}//end catch
		} // finally
	}// moveImgtoRoomImg
	
	
	/**
	 * ���� ���� ���� ��,
	 * param�� ��ġ�ϴ� �̹������� roomImages���� ã�Ƽ� temp�� ����
	 */
	public void moveImgtoTemp(List<String> imgList) {
		// �� ����
		File imgFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
		// ������ ����
		File tempFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		if(!tempFolder.exists()) {
			tempFolder.mkdirs();
		}
		if(!imgFolder.exists()) {
			imgFolder.mkdirs();
		}
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {
			for (int i = 0; i < imgList.size() ; i++) { // param���� ���� �̹����� ����ŭ �ݺ�
				File dbImg = new File(imgFolder.getAbsolutePath() + "/" + imgList.get(i));
				File temp = new File(tempFolder.getAbsolutePath() + "/" + imgList.get(i));

				fis = new FileInputStream(dbImg);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File üũ
					fos.write(data, 0, byteCnt);
				} // end while
			} // end for
			fos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (fis != null) {
				try {
					fis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}//end catch
			}//end if
			if (fos != null) {
				try {
					fos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}//end catch
			}//end if
		} // finally
	}// moveImgtoTemp
	
	
	/**
	 * temp ���� �̹��� ����
	 */
	public void removeTempImg(String fileName) {
		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");
		//������ ���ų� ��������� return
		if (!temp.exists() || temp.listFiles().length ==0) {
			return;
		}//end if
		
		File[] listFiles = temp.listFiles();
		if(fileName == null || "".equals(fileName)) { // fileName�� null | empty�� ��� temp ������ ���� ��ü����
			for (int i = 0; i < listFiles.length; i++) {
				System.gc();
				listFiles[i].delete();
			} // end for
		} else { //Ư�� fileName�� ���Դٸ� �ش� ���ϸ� ����
			for (int i = 0; i < listFiles.length; i++) {
				// �����Ϸ��� ���ϰ� ������ �̸� ����
				if (listFiles[i].getName().equals(fileName)) {
					File delImg = new File(temp + "/" + fileName);
					delImg.delete();
					break;
				} // end if
			} // end for
		}//end else
	}// removeTempImg
	
	
	/**
	 * ���� ���� �Ϸ� �� ������ roomImages�� ���� ���� 
	 * @param dbImgList
	 * @param imgFrmVO
	 */
	public void removeRoomImg(List<String> dbImgList, ImgFormVO imgFrmVO) {
		//roomImages���� ���� �̹��� ����Ʈ
			List<String> delImgList = new ArrayList<String>();
			File roomImg = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
				
			//���� �Ϸ� �� ���ο� �̹��� ����Ʈ ����
			List<String> newImgList = new ArrayList<String>();
			newImgList.add(imgFrmVO.getMainImg());
			if(imgFrmVO.getOtherImgs().length != 0) {
				for(String otherImg : imgFrmVO.getOtherImgs()) {
					newImgList.add(otherImg);
				}//end for
			}// end if
				
			for(String oldImg : dbImgList) {
				for(String newImg : newImgList) {
					if (newImg.equals(oldImg)) {
						break;
					}//end if
					delImgList.add(oldImg);
				}//end for
			}//end for
				
			//���� ����Ʈ�� ������ return
			if(delImgList.size()==0) {
				return;
			}//end if
				
			for(String imgSrc : delImgList) {
				File delImg = new File(roomImg + "/" + imgSrc);
				delImg.delete();
			}//end for
	}// removeRoomImg
	
}//class
