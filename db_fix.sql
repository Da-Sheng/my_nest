-- 数据库修复脚本
-- 执行: psql "host=your-rds-host port=5432 dbname=postgres user=sk sslmode=require" -f db_fix.sql

-- 1. 增加ID字段长度限制
ALTER TABLE blog_posts ALTER COLUMN id TYPE VARCHAR(50);
ALTER TABLE blog_categories ALTER COLUMN id TYPE VARCHAR(50);
ALTER TABLE blog_tags ALTER COLUMN id TYPE VARCHAR(50);

-- 2. 创建视图，将下划线命名法映射为驼峰命名法
DROP VIEW IF EXISTS blog_posts_view;
CREATE VIEW blog_posts_view AS
SELECT 
  id,
  slug,
  title,
  excerpt,
  content,
  author_name AS "authorName",
  author_avatar AS "authorAvatar",
  author_bio AS "authorBio",
  published_at AS "publishedAt",
  updated_at AS "updatedAt",
  tags,
  category,
  reading_time AS "readingTime",
  featured,
  cover_image AS "coverImage"
FROM blog_posts;

-- 3. 修改默认搜索路径，使视图成为默认访问对象
-- 注意：这一步可能会影响其他表的访问，请谨慎使用
-- ALTER ROLE sk SET search_path TO public, "$user";

-- 4. 验证视图是否创建成功
SELECT * FROM blog_posts_view LIMIT 1;

-- 5. 显示成功消息
SELECT '🎉 数据库修复完成！' as message;
