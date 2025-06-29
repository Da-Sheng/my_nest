-- 验证数据库表是否创建成功
-- 连接到数据库后执行此脚本

-- 1. 查看所有表
\dt

-- 2. 验证表结构
\d blog_posts
\d blog_categories  
\d blog_tags

-- 3. 检查表是否为空
SELECT 'blog_posts' as table_name, count(*) as row_count FROM blog_posts
UNION ALL
SELECT 'blog_categories', count(*) FROM blog_categories
UNION ALL  
SELECT 'blog_tags', count(*) FROM blog_tags;

-- 4. 显示数据库基本信息
SELECT current_database(), current_user, version(); 