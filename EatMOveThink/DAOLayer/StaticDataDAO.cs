using DatabaseModelProject;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAOLayer
{
    public class StaticDataDAO
    {
        public KeyValuePair<String, String> getPage(String Title)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var page = db.StaticPageDatas.Where(p => p.Title.ToLower() == Title.ToLower()).FirstOrDefault();
                if (page == null)
                    return new KeyValuePair<string, string>("", "");
                else
                    return new KeyValuePair<string, string>(page.Title, page.Data);
            }
        }
        public Boolean updatePage(String Title,String Data)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                var page = db.StaticPageDatas.Where(p => p.Title.ToLower() == Title.ToLower()).FirstOrDefault();
                if (page == null)
                {
                    StaticPageData pageN = new StaticPageData();
                    pageN.Title = Title;
                    pageN.Data = Data;
                    db.StaticPageDatas.Add(pageN);
                }
                else
                {
                    page.Data = Data;                    
                }
                try
                {
                    db.SaveChanges();
                    return true;
                }
                catch (Exception e)
                {
                    return false;
                }
            }
        }
        public Boolean setPage(String Title,String Data)
        {
            using (var db = new DatabaseModelProject.Model())
            {
                StaticPageData page = new StaticPageData();
                page.Title = Title;
                page.Data = Data;
                db.StaticPageDatas.Add(page);
                try
                {
                    db.SaveChanges();
                    return true;
                }
                catch(Exception e)
                {
                    return false;
                }
            }
        }
    }
}
