Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB771AF0B9
	for <netfs@lists.linux.dev>; Tue, 15 Oct 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.231.56.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999666; cv=none; b=PYV4B/PtS4kYNFto7CaoIPRCL/c8Hd0cimokjAuCVeGnVpxwa8JOPLlcEaEBMmWkXR7DefyW8ZzR2wrKPRb4+LuauYSuiuIk3EOyclSKRFRKuXBE+wktzDFfu7qLB2RDVn5avmtnbsz7fnfHTgLEj2IuMp0l8Z+L3wHTECs1mK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999666; c=relaxed/simple;
	bh=BzYWAhoI0axCue+kv6wY0di0ivbwBcXcR4ZVqGGktH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=luXxQNvRCA250AnmX+3cat+MzCiCXuxeAMY1L3MOxgEMGkXSdJEG9/46DDQRijVsD4aQDt7Dg+bPbiyvobvkxPPcmkwbfYKfIeODT03n/M/ZIcfw+b54CJw27EqQv8M9LBxNRA277kaeRs5yWUv+Yw+2rdJH5vkjF3x9FDthzmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn; spf=pass smtp.mailfrom=hust.edu.cn; arc=none smtp.client-ip=20.231.56.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app1 (Coremail) with SMTP id HgEQrACHjjrDcA5n9TrMBw--.6015S2;
	Tue, 15 Oct 2024 21:40:19 +0800 (CST)
Received: from [10.12.164.29] (unknown [10.12.164.29])
	by gateway (Coremail) with SMTP id _____wAHckLBcA5nX5dIAA--.51398S2;
	Tue, 15 Oct 2024 21:40:18 +0800 (CST)
Message-ID: <769f0267-f09d-46e8-854f-52f6c65996f8@hust.edu.cn>
Date: Tue, 15 Oct 2024 21:40:17 +0800
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: fix a reference of a removed file
To: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: hust-os-kernel-patches@googlegroups.com, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241015092356.1526387-1-dzm91@hust.edu.cn>
 <87jze9qyha.fsf@trenco.lwn.net>
Content-Language: en-US
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87jze9qyha.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:HgEQrACHjjrDcA5n9TrMBw--.6015S2
Authentication-Results: app1; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrZrWDJF48tw48ur43Zr1xAFb_yoWDJFb_JF
	97AFs3ZryDArs7AF18KFn8WF13A3WxCry8Xw1fAws3ta4UJ395CF93J3sYyr43Wrs29rn5
	JFWkZr9xXFy2gjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbDAYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
	8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8x
	CEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0U
	Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VACjcxG62k0Y48FwI0_Cr0_Gr1UMcIj6x8Erc
	xFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4fZr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UQzVbU
	UUUU=
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 10/15/24 21:36, Jonathan Corbet wrote:
> Dongliang Mu <dzm91@hust.edu.cn> writes:
>
>> Since 86b374d061ee ("netfs: Remove fs/netfs/io.c") removed
>> fs/netfs/io.c, we need to delete its reference in the documentation.
>>
>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>> ---
>>   Documentation/filesystems/netfs_library.rst | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
>> index f0d2cb257bb8..73f0bfd7e903 100644
>> --- a/Documentation/filesystems/netfs_library.rst
>> +++ b/Documentation/filesystems/netfs_library.rst
>> @@ -592,4 +592,3 @@ API Function Reference
>>   
>>   .. kernel-doc:: include/linux/netfs.h
>>   .. kernel-doc:: fs/netfs/buffered_read.c
>> -.. kernel-doc:: fs/netfs/io.c
> Already fixed by 368196e50194 in linux-next.

Okay, I see. Thanks for the reminder.

Dongliang Mu

>
> Thanks,
>
> jon

