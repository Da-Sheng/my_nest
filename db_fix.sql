-- 全面修复数据库列名脚本
-- 执行: psql "host=your-rds-host port=5432 dbname=postgres user=sk sslmode=require" -f db_fix_complete.sql

-- 1. 备份原始数据（可选，但建议执行）
CREATE TABLE IF NOT EXISTS blog_posts_backup AS SELECT * FROM blog_posts;

-- 2. 修改blog_posts表的列名，从下划线命名法改为驼峰命名法
ALTER TABLE blog_posts RENAME COLUMN author_name TO "authorName";
ALTER TABLE blog_posts RENAME COLUMN author_avatar TO "authorAvatar";
ALTER TABLE blog_posts RENAME COLUMN author_bio TO "authorBio";
ALTER TABLE blog_posts RENAME COLUMN published_at TO "publishedAt";
ALTER TABLE blog_posts RENAME COLUMN updated_at TO "updatedAt";
ALTER TABLE blog_posts RENAME COLUMN reading_time TO "readingTime";
ALTER TABLE blog_posts RENAME COLUMN cover_image TO "coverImage";

-- 3. 修改blog_categories表的列名
ALTER TABLE blog_categories RENAME COLUMN created_at TO "createdAt";
ALTER TABLE blog_categories RENAME COLUMN updated_at TO "updatedAt";

-- 4. 修改blog_tags表的列名
ALTER TABLE blog_tags RENAME COLUMN created_at TO "createdAt";
ALTER TABLE blog_tags RENAME COLUMN updated_at TO "updatedAt";

-- 5. 修改触发器函数以适应新的列名
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW."updatedAt" = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 6. 重新创建触发器
DROP TRIGGER IF EXISTS update_blog_posts_updated_at ON blog_posts;
CREATE TRIGGER update_blog_posts_updated_at
    BEFORE UPDATE ON blog_posts
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_blog_categories_updated_at ON blog_categories;
CREATE TRIGGER update_blog_categories_updated_at
    BEFORE UPDATE ON blog_categories
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_blog_tags_updated_at ON blog_tags;
CREATE TRIGGER update_blog_tags_updated_at
    BEFORE UPDATE ON blog_tags
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- 7. 重新创建索引（如果需要）
DROP INDEX IF EXISTS idx_blog_posts_published_at;
CREATE INDEX IF NOT EXISTS idx_blog_posts_published_at ON blog_posts("publishedAt");

-- 8. 验证修改是否成功
SELECT 
    column_name,
    data_type
FROM information_schema.columns 
WHERE table_schema = 'public' 
  AND table_name = 'blog_posts'
ORDER BY ordinal_position;

-- 9. 显示成功消息
SELECT '🎉 数据库列名修复完成！现在列名与Prisma模型匹配。' as message;