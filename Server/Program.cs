using LearningOutcomesGenerator;
using LearningOutcomesGenerator.Pages;
using Library.Pages;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Localization;
using Microsoft.Extensions.Localization;
using MudBlazor;
using MudBlazor.Services;
using Tailwind;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();
builder.Services.AddMudServices();
builder.Services.AddMudMarkdownServices();
builder.Services.AddScoped<ClipBoardService>();

builder.Services.AddLocalization(options => options.ResourcesPath = "Resources");

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

var supportedCultures = new[] { "de-DE", "en-DE" };
var localizationOptions = new RequestLocalizationOptions()
    .AddSupportedCultures(supportedCultures);
localizationOptions.RequestCultureProviders.Clear();
localizationOptions.AddInitialRequestCultureProvider(new CookieRequestCultureProvider());
app.UseRequestLocalization(localizationOptions);


/*
app.RunTailwind("tailwind");
*/

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();