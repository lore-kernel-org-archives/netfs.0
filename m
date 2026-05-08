Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D328421EE4;
	Fri,  8 May 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262065; cv=none; b=g5MaVOmbdS96/Uw9bf23iHm8M2FWK20wF39JotoYfcIW7hERCasRvCuCiW744JR0UP7a8Pgajh0rO944GChw2ZrUW7a22viQkb8CZ+Vmm3p49ctosEDrRI0DWeuGtZJ9UF9occeRsn532QTmZLRNNvb7Jt1rmybFAZpesc0VQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262065; c=relaxed/simple;
	bh=m6d49qXRXl06RFwK6IQO1C2DpYFBSBX8sil9W1AqFoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EIQugZKlrrDmJGWIdaB1NBC+nYb6zGwcxnBE0XFAEgkXmQeC4mHowHrjfEQgjGBknKuu4RUZL8jWhBeVskA5v8ZngSOenTY4ey0p/owWorPKTFBo/jJK8ggfvb23FcidTeSM+ZFmaKRvIoVKGtyDu8Jexe/6IY+c7XjTRutehGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FtLX8Ee2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FtLX8Ee2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=c4XzaOg7HOldvBJBPqmFDK1R7qTAK0U4wLJ/ZbVHYp0=; b=FtLX8Ee2NkKGkKFmjwucrwClCT
	7PHN/9RqycqXI34+VLb2gfLWjzsnVGPL6PRKWVCluK583upFPQojR8KB270++IPwvGcLnc8weqdfF
	OiM7oADRA7qgJifHJFM1j509Ixv/BdVMZTEqbcQa+mRZEHt4QpK/r+sldD/V86w/nvOpqs0fBTVJj
	yoerdZKyoZHZDii3uQdydJprd+EDFAhxRO5thYRw625+DMUNCB8z+AQikQEcsGZzIt3rKdufx01s7
	lRU4qwmGtq+E6wzpoFnL2J2WoXcOHD41/2wuiom2J4kJm8/1Wnl0AweRHjZvvvhn8c8Tko9/rbEVV
	fsXdWZGQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLPC1-00000007Aci-0wQz;
	Fri, 08 May 2026 17:40:53 +0000
Message-ID: <5f68ac30-21ac-494b-a140-2307e236f0a2@infradead.org>
Date: Fri, 8 May 2026 10:40:49 -0700
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] docs: fix repeated word 'that' across documentation
To: Shuah Khan <skhan@linuxfoundation.org>,
 Adrien Reynard <reynard.adrien.08@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Jonathan Corbet <corbet@lwn.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS"
 <driver-core@lists.linux.dev>,
 "open list:FILESYSTEMS [NETFS LIBRARY]" <netfs@lists.linux.dev>,
 "open list:FILESYSTEMS [NETFS LIBRARY]" <linux-fsdevel@vger.kernel.org>,
 "open list:TRACING" <linux-trace-kernel@vger.kernel.org>
References: <20260508163759.16231-1-reynard.adrien.08@gmail.com>
 <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1501caea-8cff-4968-aca6-e8d4b20e0e80@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/8/26 10:15 AM, Shuah Khan wrote:
> On 5/8/26 10:37, Adrien Reynard wrote:
> 
> Missing commit log in all your patches - I don't patch 1/5 in
> my Inbox.
> 
>> Signed-off-by: Adrien Reynard <reynard.adrien.08@gmail.com>
>> ---
>>   Documentation/RCU/rcu.rst                          | 2 +-
>>   Documentation/driver-api/driver-model/overview.rst | 2 +-
>>   Documentation/filesystems/netfs_library.rst        | 2 +-
>>   Documentation/trace/histogram-design.rst           | 2 +-
>>   Documentation/trace/histogram.rst                  | 2 +-
>>   5 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
>> index bf6617b330a7..320ad3292b75 100644
>> --- a/Documentation/RCU/rcu.rst
>> +++ b/Documentation/RCU/rcu.rst
>> @@ -32,7 +32,7 @@ Frequently Asked Questions
>>     Just as with spinlocks, RCU readers are not permitted to
>>     block, switch to user-mode execution, or enter the idle loop.
>>     Therefore, as soon as a CPU is seen passing through any of these
>> -  three states, we know that that CPU has exited any previous RCU
>> +  three states, we know that CPU has exited any previous RCU
> 
> The original intent might have been to say, "that cpu", so adding
> the missing comma after the first "that" or change "that" to "the"
> would make sense.

Not a comma, please.
I don't see a problem with "that that," but "that the" could also be OK.

> 
> 
>>     read-side critical sections.  So, if we remove an item from a
>>     linked list, and then wait until all CPUs have switched context,
>>     executed in user mode, or executed in the idle loop, we can


-- 
~Randy

