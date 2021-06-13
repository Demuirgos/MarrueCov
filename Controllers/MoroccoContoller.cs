using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Api.Services;
using Api.Models;

namespace Api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CountryController : ControllerBase
    {
        private readonly MainService _Service;

        public CountryController(MainService centralService)
        {
            _Service = centralService;
        }

        [HttpGet]
        public ActionResult<Country> Get() =>
            _Service.Get();
    }
}
