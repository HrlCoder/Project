package org.example.util;

import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;
import org.example.model.DocInfo;
import org.example.model.Weight;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *构建索引：
 * 正排索引：从本地文件数据中读取到java内存（类似数据库保存的数据）
 * 倒排索引：构建Map<String，List<信息>>（类似数据库hash索引）
 * Map键：关键词（分词来做）
 * Map值-信息：
 *  （1）docInfo对象引用或是docInfo的id
 *  （2）权重（标题对应关键词数量*10 + 正文对应关键词数量*1）
 */
public class Index {
    //正排索引
    private static final List<DocInfo> FORWARD_INDEX = new ArrayList<>();
    //倒排索引
    private static final Map<String,List<Weight>> INVERTED_INDEX = new HashMap<>();

    /**
     * 构建正排索引的内容：从本地raw_data.txt中读取
     */
    public static void buildForwardIndex() {
        try {
            FileReader fr = new FileReader(Parser.RAW_DATA);
            BufferedReader br = new BufferedReader(fr);
            int id = 0; //行号设置为docInfo的id
            String line;
            while ((line = br.readLine()) != null) {
                if(line.trim().equals("")) {
                    continue;//保证最后一行空字符串不进行操作
                }
                //一行数据对应一个DocInfo对象，类似数据库一行数据对应java对象
                DocInfo doc = new DocInfo();
                doc.setId(++id);
                String[] parts = line.split("\3");//每一行按\3间隔符切割
                doc.setTitle(parts[0]);
                doc.setUrl(parts[1]);
                doc.setContent(parts[2]);
                //添加到正排索引
//                System.out.println(doc);
                FORWARD_INDEX.add(doc);
            }
        } catch (IOException e) {
            //不要吃异常，往外抛。从而结束程序
            throw new RuntimeException(e);
        }
    }

    /**
     * 构建倒排索引：从java内存中正排索引获取文档信息来构建
     */
    public static void buildInvertedIndex() {
        for(DocInfo doc : FORWARD_INDEX) {
            //一个doc，分别对标题和正文分词，每一个分词生产一个weight对象，需要计算权重
            Map<String,Weight> cache = new HashMap<>();
            List<Term> titleFencis = ToAnalysis.parse(doc.getTitle()).getTerms();
            for (Term titleFenci : titleFencis) {//标题分词并遍历处理
                Weight w = cache.get(titleFenci.getName());//获取标题分词到键对应的weight对象
                if(w == null) {//如果没有，就创建一个并放到map中
                    w = new Weight();
                    w.setDoc(doc);
                    w.setKeyword(titleFenci.getName());
                    cache.put(titleFenci.getName(),w);
                }
                //标题分词，权重加10
                w.setWeight(w.getWeight()+10);
            }
            List<Term> contentFencis = ToAnalysis.parse(doc.getContent()).getTerms();
            for (Term contentFenci : contentFencis) {
                Weight w = cache.get(contentFenci.getName());
                if(w == null) {
                    w = new Weight();
                    w.setDoc(doc);
                    w.setKeyword(contentFenci.getName());
                    cache.put(contentFenci.getName(),w);
                }
                w.setWeight(w.getWeight()+1);
            }
            //把临时保存的Map数据（Keyword—weight），全部保存到倒排索引中
            for (Map.Entry<String,Weight> e: cache.entrySet()) {
                String keyword = e.getKey();
                Weight w = e.getValue();
                //先在倒排索引中，通过keyword获取已有的值
                List<Weight> weights = INVERTED_INDEX.get(keyword);
                if(weights == null) {//如果拿不到，就创建一个，并存放级倒排索引
                    weights = new ArrayList<>();
                    INVERTED_INDEX.put(keyword,weights);
                }
//                System.out.println(keyword+"：("+w.getDoc().getId()+","+w.getWeight()+")");
                weights.add(w);//倒排中，添加当前文档每个分词对应的weight对象
            }
        }
    }

    //通过关键词（分词）在倒排中查找映射的文档（多个文档，倒排拉链）
    public static List<Weight> get(String keyword) {
        return INVERTED_INDEX.get(keyword);
    }

    public static void main(String[] args) {
        //测试正排索引是否正确
        Index.buildForwardIndex();
//        FORWARD_INDEX
//                .stream()
//                .forEach(System.out::println);
        //根据正排索引构建倒排
        Index.buildInvertedIndex();
        //测试倒排内容是否正确
        for (Map.Entry<String, List<Weight>> e : INVERTED_INDEX.entrySet()) {
            String keyword = e.getKey();
            System.out.print(keyword+"：");
            List<Weight> weights = e.getValue();//不校验weight中的doc对象，正排索引已经测试过
            weights.stream()
                    .map(w->{//map操作：把list中每一个对象转换成其他对象
                        return "（"+w.getDoc().getId()+","+w.getWeight()+"）";
                    })//转换完 ，会变成List<String>
//                    .collect(Collectors.toList());
                    .forEach(System.out::print);
            System.out.println();
        }
    }
}
