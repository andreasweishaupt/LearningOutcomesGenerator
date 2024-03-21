using Microsoft.JSInterop;

namespace LearningOutcomesGenerator.Pages;

public sealed class ClipBoardService
{
    private readonly IJSRuntime _jsRuntime;
        
    public ClipBoardService(IJSRuntime jsRuntime)
    {
        _jsRuntime = jsRuntime;
    }
        
    public async Task SetTextAsync(string text)
    {
        await _jsRuntime.InvokeVoidAsync("navigator.clipboard.writeText", text);
    }
}