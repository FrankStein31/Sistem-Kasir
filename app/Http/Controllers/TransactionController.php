<?php

namespace App\Http\Controllers;

use App\Models\Transaction;
use App\Models\Product;
use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\TransactionsExport;

class TransactionController extends Controller
{
    public function index()
    {
        $transactions = Transaction::with('product')->get();
        $products = Product::all();
        return view('content.transaction.index', compact('transactions', 'products'));
    }

    public function savetransaction(Request $request)
    {
        $data = $request->only([
            'customer_name',
            'qty',
            'method_payment',
            'total',
            'product_id',
        ]);

        $transactionId = $request->input('transaction_id');
        $transaction = $transactionId ? Transaction::find($transactionId) : new Transaction();

        if (!$transaction) {
            return redirect()->back()->withErrors(['error' => 'Data not found.']);
        }

        $transaction->fill($data);

        if ($transaction->save()) {
            return redirect()->route('transaction.index')->with('success', 'Data saved successfully.');
        }

        return redirect()->back()->withErrors(['error' => 'Failed to save data.']);
    }

    public function deletetransaction($id)
    {
        $transaction = Transaction::find($id);

        if ($transaction && $transaction->delete()) {
            return redirect()->route('transaction.index')->with('success', 'Data deleted successfully.');
        }

        return redirect()->back()->withErrors(['error' => 'Failed to delete data.']);
    }

    public function exportToExcel(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        $methodPayment = $request->input('method_payment');

        return Excel::download(new TransactionsExport($startDate, $endDate, $methodPayment), 'transactions.xlsx');
    }
}
