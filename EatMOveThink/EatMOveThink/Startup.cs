using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(EatMOveThink.Startup))]
namespace EatMOveThink
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
