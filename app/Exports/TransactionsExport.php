<?php

namespace App\Exports;

use App\Models\Transaction;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;

class TransactionsExport implements FromCollection, WithHeadings
{
    protected $startDate;
    protected $endDate;
    protected $methodPayment;

    public function __construct($startDate = null, $endDate = null, $methodPayment = null)
    {
        $this->startDate = $startDate;
        $this->endDate = $endDate;
        $this->methodPayment = $methodPayment;
    }

    public function collection()
    {
        $query = Transaction::with('product');

        if ($this->startDate && $this->endDate) {
            $query->whereBetween('created_at', [$this->startDate, $this->endDate]);
        }

        if ($this->methodPayment && $this->methodPayment !== 'all') {
            $query->where('method_payment', $this->methodPayment);
        }

        return $query->get()->map(function ($transaction) {
            return [
                'transaction_id' => $transaction->transaction_id,
                'customer_name' => $transaction->customer_name,
                'qty' => $transaction->qty,
                'method_payment' => $transaction->method_payment,
                'total' => $transaction->total,
                'product' => $transaction->product->name ?? 'N/A',
            ];
        });
    }

    public function headings(): array
    {
        return [
            'Transaction ID',
            'Customer Name',
            'Quantity',
            'Method Payment',
            'Total',
            'Product',
        ];
    }
}
