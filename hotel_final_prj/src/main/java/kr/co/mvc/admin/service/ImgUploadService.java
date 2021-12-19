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
	 * 이미지 파일 추가 프로세스 (AJAX)
	 * @param request
	 * @return jsonString
	 */
	public String addImgFileProcess(HttpServletRequest request) {

		//temp폴더에 파일 업로드
		File uploadPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		if(!uploadPath.exists()){ // 경로에 업로드 폴더가 없으면 생성
			uploadPath.mkdirs();
		}//end if
		
		int maxSize = 1024*1024*5; // 5 Mbyte
		MultipartRequest mr = null;
		JSONObject imgJson = null;
		try {
			mr = new MultipartRequest(request, uploadPath.getAbsolutePath(), maxSize, "UTF-8");
			
			String fileName = mr.getParameter("fileName");
			
			//main이미지로 등록되었으면 파일명 변경하여 저장
			if(!("".equals(fileName)) && fileName != null){
				markMainImg(fileName);
			}//end if
			
			//temp 파일에 있는 이미지 리스트 조회하여 JSONObject로 Return 
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
	 * 이미지 파일 삭제 프로세스 (AJAX)
	 * @param imgName
	 * @return jsonString
	 */
	public String removeImgFileProcess(String imgName) {
		//특정이미지 삭제 후 temp폴더에 있는 이미지 리스트 재조회
		removeTempImg(imgName);
		List<ImgUploadVO> imgList = searchImgList();
			
		//다시 조회한 이미지 리스트 json에 할당
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
	 * 메인이미지 등록시 파일명을 mainImg로 변경하여 저장하는 method
	 * @param fileName
	 */
	public void markMainImg(String fileName) {
		File selectedImgPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp/" + fileName);
		File mainImgPath = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp/"
				+ fileName.substring(0, fileName.indexOf(".")) + "_main" + fileName.substring(fileName.indexOf(".")));

		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		// 전체 파일 리스트 조회 후 main 포함되어있거나 같은 이름으로 저장되어있는 파일이 있다면 삭제 후 rename 처리
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
	 * temp 파일에 존재하는 이미지 목록 조회
	 * @return List<UploadImgVO>
	 */
	public List<ImgUploadVO> searchImgList() {
		List<ImgUploadVO> list = new ArrayList<ImgUploadVO>();

		// 1. 파일 리스트를 가져올 파일 생성
		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");

		if(!temp.exists()) {
			temp.mkdirs();
		}
		
		// 2. 해당 폴더의 모든 파일, 디렉토리를 얻음
		File[] listFiles = null;
		
		if(temp.listFiles() != null) { // 널이 아닐때 !
			listFiles = temp.listFiles();
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd a HH:mm:ss");

			ImgUploadVO iuVO = null;
			for (File file : listFiles) {
				// 3. 파일에 대해서만 정보를 얻음
				if (file.isFile()) {
					// 4. list에 파일명 할당
					iuVO = new ImgUploadVO();
					iuVO.setImgName(file.getName());
					iuVO.setImgLength((int) ((file.length()) / 1024));
					iuVO.setLastModified(sdf.format(new Date(file.lastModified())));
					list.add(iuVO);
				} // end if
			} // end for

			// 등록순서대로 정렬
			Collections.sort(list, new CompareDateAsc());
		}//end if
		return list;
	}// searchImgList

	/**
	 * searchImgList에서 반환된 list를 등록순서대로 정렬하는 inner Class
	 * @author user
	 */
	public class CompareDateAsc implements Comparator<ImgUploadVO> {
		@Override
		public int compare(ImgUploadVO o1, ImgUploadVO o2) {
			return o1.getLastModified().compareTo(o2.getLastModified());
		}
	}//CompareDateAsc

	/**
	 * 객실추가/수정 성공 시 temp에 있는 사진들을 roomImages폴더로 이동
	 */
	public void moveImgtoRoomImg() {
		// 원 폴더
		File tempFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");
		// 복사할 폴더
		File imgFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
		
		if(!tempFolder.exists()) {
			tempFolder.mkdirs();
		}//end if
		if(!imgFolder.exists()) {
			imgFolder.mkdirs();
		}//end if
		
		// 원 폴더의 파일수만큼 파일 배열 생성
		File[] fileList = tempFolder.listFiles();

		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		try {
			//파일 복사
			for (File file : fileList) {
				File temp = new File(imgFolder.getAbsolutePath() + "/" + file.getName());

				fis = new FileInputStream(file);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File 체크
					fos.write(data, 0, byteCnt);
				} // end while
			} // end for
			fos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			//연결 끊기
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
	 * 객실 정보 수정 시,
	 * param과 일치하는 이미지들을 roomImages에서 찾아서 temp에 복사
	 */
	public void moveImgtoTemp(List<String> imgList) {
		// 원 폴더
		File imgFolder = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
		// 복사할 폴더
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
			for (int i = 0; i < imgList.size() ; i++) { // param으로 받은 이미지의 수만큼 반복
				File dbImg = new File(imgFolder.getAbsolutePath() + "/" + imgList.get(i));
				File temp = new File(tempFolder.getAbsolutePath() + "/" + imgList.get(i));

				fis = new FileInputStream(dbImg);
				fos = new FileOutputStream(temp);

				byte[] data = new byte[512];
				int byteCnt = 0;
				while ((byteCnt = fis.read(data)) != -1) { // End Of File 체크
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
	 * temp 폴더 이미지 삭제
	 */
	public void removeTempImg(String fileName) {
		File temp = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/temp");
		//폴더가 없거나 비어있으면 return
		if (!temp.exists() || temp.listFiles().length ==0) {
			return;
		}//end if
		
		File[] listFiles = temp.listFiles();
		if(fileName == null || "".equals(fileName)) { // fileName이 null | empty일 경우 temp 폴더의 파일 전체삭제
			for (int i = 0; i < listFiles.length; i++) {
				System.gc();
				listFiles[i].delete();
			} // end for
		} else { //특정 fileName이 들어왔다면 해당 파일만 삭제
			for (int i = 0; i < listFiles.length; i++) {
				// 삭제하려는 파일과 동일한 이름 삭제
				if (listFiles[i].getName().equals(fileName)) {
					File delImg = new File(temp + "/" + fileName);
					delImg.delete();
					break;
				} // end if
			} // end for
		}//end else
	}// removeTempImg
	
	
	/**
	 * 객실 수정 완료 후 삭제된 roomImages의 파일 삭제 
	 * @param dbImgList
	 * @param imgFrmVO
	 */
	public void removeRoomImg(List<String> dbImgList, ImgFormVO imgFrmVO) {
		//roomImages에서 지울 이미지 리스트
			List<String> delImgList = new ArrayList<String>();
			File roomImg = new File("C:/Users/user/git/hotel_final_prj/hotel_final_prj/src/main/webapp/roomImages");
				
			//수정 완료 후 새로운 이미지 리스트 세팅
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
				
			//지울 리스트가 없으면 return
			if(delImgList.size()==0) {
				return;
			}//end if
				
			for(String imgSrc : delImgList) {
				File delImg = new File(roomImg + "/" + imgSrc);
				delImg.delete();
			}//end for
	}// removeRoomImg
	
}//class
