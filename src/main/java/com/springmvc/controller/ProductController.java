package com.springmvc.controller;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.csv.CSVFormat;
import org.apache.commons.csv.CSVParser;
import org.apache.commons.csv.CSVRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.springmvc.domain.product;
import com.springmvc.domain.product_connect;
import com.springmvc.domain.product_detail;
import com.springmvc.domain.product_ingredient;
import com.springmvc.service.ProductService;

@Controller
public class ProductController {

    @Autowired
    ProductService service;

    @Autowired
    private ServletContext servletContext;

    private static final String productResource = "/resources/csv/products.csv";
    private static final String ingredientResource = "/resources/csv/ingredients.csv";
    private static final String connectResource = "/resources/csv/connect.csv";

    public void processAllCsvFiles() throws IOException {
        List<product> products = readProductCsv(productResource);
        List<product_ingredient> ingredients = readIngeredientCsv(ingredientResource);
        List<product_connect> connects = readConnectCsv(connectResource);
        
        for (product pd : products) {
            if (!service.isProductExist(pd.getProduct_id())) {
                service.processProduct(pd);
            }
        }

        for (product_ingredient pdi : ingredients) {
            if (!service.isIngredientExist(pdi.getIngredient_id())) {
                service.processIngredient(pdi);
            }
        }

        for (product_connect pdc : connects) {
            if (!service.isConnectExist(pdc.getId())) {
                service.processConnect(pdc);
            }
        }
    }

    // CSV 파싱

    public List<product> readProductCsv(String filePath) throws IOException {
        List<product> products = new ArrayList<>();
        File file = new File(servletContext.getRealPath(filePath)); // 실제 파일 시스템 경로

        try (CSVParser parser = new CSVParser(new FileReader(file), CSVFormat.DEFAULT.withHeader())) {
            for (CSVRecord record : parser) {
                product pd = new product();
                pd.setProduct_id(Integer.parseInt(record.get("product_id")));
                pd.setName(record.get("name"));
                pd.setPrice(Integer.parseInt(record.get("price")));
                pd.setBrand(record.get("brand"));
                pd.setCategory(record.get("category"));
                pd.setLink(record.get("link"));
                pd.setImage(record.get("image"));
                products.add(pd);
            }
        }
        return products;
    }

    public List<product_ingredient> readIngeredientCsv(String filePath) throws IOException {
        List<product_ingredient> ingredients = new ArrayList<>();
        File file = new File(servletContext.getRealPath(filePath)); // 실제 파일 시스템 경로

        try (CSVParser parser = new CSVParser(new FileReader(file), CSVFormat.DEFAULT.withHeader())) {
            for (CSVRecord record : parser) {
                product_ingredient pdi = new product_ingredient();
                pdi.setIngredient_id(Integer.parseInt(record.get("ingredient_id")));
                pdi.setKorean(record.get("korean"));
                pdi.setEnglish(record.get("english"));
                ingredients.add(pdi);
            }
        }
        return ingredients;
    }

    public List<product_connect> readConnectCsv(String filePath) throws IOException {
        List<product_connect> connects = new ArrayList<>();
        File file = new File(servletContext.getRealPath(filePath)); // 실제 파일 시스템 경로

        try (CSVParser parser = new CSVParser(new FileReader(file), CSVFormat.DEFAULT.withHeader())) {
            for (CSVRecord record : parser) {
                product_connect pdc = new product_connect();
                pdc.setId(Integer.parseInt(record.get("id")));
                pdc.setProduct_id(Integer.parseInt(record.get("product_id")));
                pdc.setIngredient_id(Integer.parseInt(record.get("ingredient_id")));
                pdc.setWarning_level(record.get("warning_level"));
                connects.add(pdc);
            }
        }
        return connects;
    }
    
    @GetMapping("/processCsv")
    public String processCsvFiles(RedirectAttributes redirectAttributes) {
        try {
            processAllCsvFiles();

            redirectAttributes.addAttribute("category", "all");
            redirectAttributes.addAttribute("pageNum", 1);
            return "redirect:/product/list?pageNum=1"; 
        } catch (IOException e) {
            e.printStackTrace(); 
            return "error";
        }
    }

}
