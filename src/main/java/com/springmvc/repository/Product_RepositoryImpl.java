package com.springmvc.repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springmvc.domain.product;
import com.springmvc.domain.product_connect;
import com.springmvc.domain.product_connect_detail;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.product_ingredient;
import com.springmvc.domain.product_row;

@Repository
public class Product_RepositoryImpl implements Product_Repository {

	  private JdbcTemplate jdbcTemplate;

	    @Autowired
	    public void setDataSource(DataSource dataSource) {
	        this.jdbcTemplate = new JdbcTemplate(dataSource);
	    }

	    //product
	    
	    public boolean isProductExist(int productId) {
	    	String sql = "select count(*) from product where product_id=?";
	    	Integer count = jdbcTemplate.queryForObject(sql, new Object[]{productId}, Integer.class);
	    	return count != null && count > 0;
	    }
	    
	    public void saveProduct(product pd) {
	        String sql = "insert into product (product_id, name, price, brand, category, link, image) values (?, ?, ?, ?, ?, ?, ?)";
	        jdbcTemplate.update(sql, pd.getProduct_id(), pd.getName(), pd.getPrice(), pd.getBrand(), pd.getCategory(), pd.getLink(), pd.getImage());
	    }
	    
	    //ingredient
	    
	    public boolean isIngredientExist(int ingredientId) {
	    	String sql = "select count(*) from product_ingredient where ingredient_id=?";
	    	Integer count = jdbcTemplate.queryForObject(sql, new Object[]{ingredientId}, Integer.class);
	    	return count != null && count > 0;
	    }
	    
	    public void saveIngredient(product_ingredient ingredient) {
	        String sql = "insert into product_ingredient (ingredient_id, korean, english) values (?, ?, ?)";
	        jdbcTemplate.update(sql, ingredient.getIngredient_id(), ingredient.getKorean(), ingredient.getEnglish());
	    }
	    
	    //connect
	    
	    public boolean isConnectExist(int connectId) {
	    	String sql = "select count(*) from product_connect where id=?";
	    	Integer count = jdbcTemplate.queryForObject(sql, new Object[]{connectId}, Integer.class);
	    	return count != null && count > 0;
	    }
	    
	    public void saveConnect(product_connect connect) {
	        String sql = "insert into product_connect (id, product_id, ingredient_id, warning_level) values (?, ?, ?, ?)";
	        jdbcTemplate.update(sql, connect.getId(), connect.getProduct_id(), connect.getIngredient_id(), connect.getWarning_level());
	    }
	    
	    
	    public List<product_detail> getProductDetail(int offset, int limit) {
	        String sql = "select p.product_id, p.name, p.price, p.brand, p.category, p.link, p.image, " +
	                     "pi.korean as ingredient_korean, pi.english as ingredient_english, pc.warning_level " +
	                     "from product p " +
	                     "left join product_connect pc on p.product_id = pc.product_id " +
	                     "left join product_ingredient pi on pc.ingredient_id = pi.ingredient_id " +
	                     "ORDER BY p.product_id limit ?, ?";

	        List<product_row> rows = jdbcTemplate.query(sql, new Object[]{offset, limit}, new Product_RowMapper());

	        // 제품을 Map에 저장하여 중복 없이 관리
	        Map<Integer, product_detail> productMap = rows.stream()
	            .collect(Collectors.toMap(
	                product_row::getProductId,
	                row -> {
	                    product_detail product = new product_detail();
	                    product.setProductId(row.getProductId());
	                    product.setName(row.getName());
	                    product.setPrice(row.getPrice());
	                    product.setBrand(row.getBrand());
	                    product.setCategory(row.getCategory());
	                    product.setLink(row.getLink());
	                    product.setImage(row.getImage());
	                    return product;
	                },
	                (existing, replacement) -> existing // 같은 product_id의 경우 기존 값 유지
	            ));

	        // 성분 정보 및 경고 수준을 각 제품에 추가
	        for (product_row row : rows) {
	            product_detail product = productMap.get(row.getProductId());
	            if (product != null && row.getIngredientKorean() != null) {
	                product_connect_detail ingredient = new product_connect_detail();
	                ingredient.setKorean(row.getIngredientKorean());
	                ingredient.setEnglish(row.getIngredientEnglish());
	                ingredient.setWarningLevel(row.getWarningLevel());  // 경고 수준 설정

	                // 성분 리스트가 비어있는 경우 초기화
	                if (product.getIngredients() == null) {
	                    product.setIngredients(new ArrayList<>());
	                }
	                // 성분 추가
	                product.getIngredients().add(ingredient);
	            }
	        }

	        // product_detail 리스트 반환
	        return new ArrayList<>(productMap.values());
	    }

	    
	    public void addProduct(product product) {
	        String sql = "INSERT INTO product (name, price, brand, category, link, image) VALUES (?, ?, ?, ?, ?, ?)";
	        jdbcTemplate.update(sql, product.getName(), product.getPrice(), product.getBrand(),
	                product.getCategory(), product.getLink(), product.getImage());
	    }

	    public int getLastInsertId() {
	        return jdbcTemplate.queryForObject("SELECT LAST_INSERT_ID()", Integer.class);
	    }
	    
	    public List<product> getProduct(int offset, int limit){
	        String sql = "select * from product order by product_id limit ?, ?";
	        return jdbcTemplate.query(sql, new Object[]{offset, limit}, new ProductRowMapper());
	    }
	    
	    public List<product> getProductByCategory(int limit, int offset, String category){
	        String sql = "select * from product where category = ? order by product_id limit ?, ?";
	        return jdbcTemplate.query(sql, new Object[]{category, offset, limit}, new ProductRowMapper());
	    }
	    
	    
	    
	    
	    public int countProduct() {
	    	 String sql = "select count(*) from product";
	    	 return jdbcTemplate.queryForObject(sql, Integer.class);
	    }

	    
	    @Override
	    public List<product_detail> getProductDetailByCategory(String category, int offset, int limit) {
	        String sql = "select p.product_id, p.name, p.price, p.brand, p.category, p.link, p.image, " +
	                     "pi.korean as ingredient_korean, pi.english as ingredient_english, pc.warning_level " +
	                     "from product p " +
	                     "left join product_connect pc on p.product_id = pc.product_id " +
	                     "left join product_ingredient pi on pc.ingredient_id = pi.ingredient_id " +
	                     "where p.category = ? " +
	                     "ORDER BY p.product_id " +
	                     "LIMIT ? OFFSET ?";

	        // Query 실행, product_row 리스트 반환
	        List<product_row> rows = jdbcTemplate.query(sql, new Object[]{category, limit, offset}, new Product_RowMapper());

	        // Map에 product_detail 저장
	        Map<Integer, product_detail> productMap = rows.stream()
	            .collect(Collectors.toMap(
	                product_row::getProductId,
	                row -> {
	                    // 각 product_detail 생성 및 필드 설정
	                    product_detail product = new product_detail();
	                    product.setProductId(row.getProductId());
	                    product.setName(row.getName());
	                    product.setPrice(row.getPrice());
	                    product.setBrand(row.getBrand());
	                    product.setCategory(row.getCategory());
	                    product.setLink(row.getLink());
	                    product.setImage(row.getImage());
	                    return product;
	                },
	                (existing, replacement) -> existing // 이미 존재하는 product_id의 경우 기존 값을 유지
	            ));

	        // 성분 및 경고 수준을 product_detail에 추가
	        for (product_row row : rows) {
	            product_detail product = productMap.get(row.getProductId());
	            if (product != null) {
	                if (row.getIngredientKorean() != null) {
	                    // product_connect_detail 객체 생성 및 설정
	                    product_connect_detail ingredient = new product_connect_detail();
	                    ingredient.setKorean(row.getIngredientKorean());
	                    ingredient.setEnglish(row.getIngredientEnglish());
	                    ingredient.setWarningLevel(row.getWarningLevel()); // 경고 수준 추가

	                    // 성분 리스트가 비어 있으면 새로 생성
	                    if (product.getIngredients() == null) {
	                        product.setIngredients(new ArrayList<>());
	                    }
	                    // 성분 및 경고 수준 추가
	                    product.getIngredients().add(ingredient);
	                }
	            }
	        }

	        // 결과 반환: product_detail 객체 리스트
	        return new ArrayList<>(productMap.values());
	    }

	    
	    @Override
	    public int countProductByCategory(String category) {
	        String sql = "select count(*) from product where category = ?";
	        return jdbcTemplate.queryForObject(sql, new Object[]{category}, Integer.class);
	    }
	    
	    
	    
	    public product_detail getProductDetailById(int productId) {
	        String sql = "select p.product_id, p.name, p.price, p.brand, p.category, p.link, p.image, " +
	                     "pi.korean as ingredient_korean, pi.english as ingredient_english, pc.warning_level " +
	                     "from product p " +
	                     "left join product_connect pc on p.product_id = pc.product_id " +
	                     "left join product_ingredient pi on pc.ingredient_id = pi.ingredient_id " +
	                     "where p.product_id = ?";

	        List<product_row> rows = jdbcTemplate.query(sql, new Object[]{productId}, new Product_RowMapper());

	        if (rows.isEmpty()) {
	            return null;
	        }

	        product_row row = rows.get(0);

	        product_detail product = new product_detail();
	        product.setProductId(row.getProductId());
	        product.setName(row.getName());
	        product.setPrice(row.getPrice());
	        product.setBrand(row.getBrand());
	        product.setCategory(row.getCategory());
	        product.setLink(row.getLink());
	        product.setImage(row.getImage());

	        List<product_connect_detail> ingredients = rows.stream()
	            .filter(r -> r.getIngredientKorean() != null)
	            .map(r -> {
	                product_connect_detail ingredient = new product_connect_detail();
	                ingredient.setKorean(r.getIngredientKorean());
	                ingredient.setEnglish(r.getIngredientEnglish());
	                ingredient.setWarningLevel(r.getWarningLevel());
	                return ingredient;
	            })
	            .collect(Collectors.toList());

	        product.setIngredients(ingredients);

	        return product;
	    }
}
