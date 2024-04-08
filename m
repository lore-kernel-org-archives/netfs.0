Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F20A487BF
	for <netfs@lists.linux.dev>; Mon,  8 Apr 2024 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563812; cv=none; b=mpiRuYZX2uKtPTXB9kKkES4EM5e+QMuW5FjgxffOqjztvwU862qdY3/rVQuzk6q2OFz+C+EVraIV/B7+7S7Pack1UWZsIZYQtfo1NoknGSvvngS4hV0/1Tz0UuABfxUpVXgKBCgs5Mk30+ZWuW6VDpw4yJqimykP6ILClb/KMts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563812; c=relaxed/simple;
	bh=zXiKh5YgqlUxpR6CzKT5LAt+pceSuhonqTRSJ9s3Qe0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P7LI7DKZJVFfCwyqJkCo/hWeyrsON4YF7rkEzQNwJgGxibeOHmY2nM+RKUONNEAydS/0HvNdcHYfRJORkfseGiux5/XMP3hMiiPIQxbQTtDP7wxJ2yoOmUvjynMZ4QP4D8HSXYy62hwRJuD5FVGc6mJBzmqZThjUOASHBRQ4eoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEx2WDet; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEx2WDet"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so5855707a12.2
        for <netfs@lists.linux.dev>; Mon, 08 Apr 2024 01:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712563809; x=1713168609; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jyCV40Jnj0ra4h5fmgg7SMMlhSo9ReCJm95L9ABZkU=;
        b=mEx2WDetlFttJCsupLzhPMQp7Tl9KArjAXEMASA31rHzT/eCywLxaba+tWLveuNx8F
         1Df3B3rDMyvAc9ztEcIU0e6mOQs319T8fbpDfWULFKGHVSBOMpVOY5A6wnsvi7/WToK/
         hi/OWsFDeScd/oN/FLTcM6uq/+dQZbA3FSg3YG8IIH6g2FR+IwAWCaag9S9d0Prg1Qd1
         0V4OryQsm5+uJdkxE3LlZa3TvmauRc9ig6Eh9jWqVP5VyzH6hqUfwtsd21E3RBzi+XoB
         /DArW9ZBlnMY/e/VabWChs0CE4rM/qVvbaftLEXOkP8SmM7fOY2TdV37Acci5Ux2PoXr
         O/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712563809; x=1713168609;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jyCV40Jnj0ra4h5fmgg7SMMlhSo9ReCJm95L9ABZkU=;
        b=sM45iqrxUNwmpZnufkYOk7r8SJLZa9c2f8htQGRm2GPFAnfIc2IWe0CRN733zTs/OA
         XykOXvxLOe731G5vOEhZ3K8YZy1WyXvS32XWv5cPNAz8nVptU3zRTTGtzuVv12Jnz0Cr
         NT8mVOwcdto2E+pZxgvtPFpo8RreOkjofHEAZPYQnrvnJ3zNinOUF7ev0mQjVAdE6Eup
         98RHuMhP4WjHY0wgYJ/fxmgxUt8VnWThLHq1FSj4CaiyWmrObd0zjDOAAeR1jEmbI/YK
         Ee7LSASY52K0G9XWSV1IR9jpnohrCoJ1/TOUpGFy78fbGkJa7IbXGh1W3nDJnNO70/wT
         tX5Q==
X-Gm-Message-State: AOJu0YwLa+bTtrDcmuepgomrrfzud5dGhSx917P56eZfve6uWihycPJv
	ZmMA++MN74UmOLYXTfgnEJ+WmiFJKmsYMsojgR/O68D41GF1f08cMUfNPBsE9uc=
X-Google-Smtp-Source: AGHT+IHPFgS+a6gYAF8FmFXqOMauqttCC7r6u5F7q5xAS+xd3Y1nsxqSTJN19ArBz85Ql86LosbJ3g==
X-Received: by 2002:a50:875e:0:b0:56e:f64:aaf6 with SMTP id 30-20020a50875e000000b0056e0f64aaf6mr5104774edv.5.1712563808763;
        Mon, 08 Apr 2024 01:10:08 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id n20-20020a05640206d400b0056e6a39cfb0sm96934edy.3.2024.04.08.01.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 01:10:08 -0700 (PDT)
Date: Mon, 8 Apr 2024 10:21:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: dhowells@redhat.com
Cc: netfs@lists.linux.dev
Subject: [bug report] netfs: New writeback implementation
Message-ID: <f61c6d0f-17ab-4182-b7fd-512c7de2047b@moroto.mountain>
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello David Howells,

Commit 34e1ec492187 ("netfs: New writeback implementation") from Mar
18, 2024 (linux-next), leads to the following Smatch static checker
warning:

	fs/netfs/write_collect.c:55 netfs_folio_written_back()
	warn: duplicate check 'group == (854)' (previous on line 53)

fs/netfs/write_collect.c
    33 int netfs_folio_written_back(struct folio *folio)
    34 {
    35         enum netfs_folio_trace why = netfs_folio_trace_clear;
    36         struct netfs_folio *finfo;
    37         struct netfs_group *group = NULL;
    38         int gcount = 0;
    39 
    40         if ((finfo = netfs_folio_info(folio))) {
    41                 /* Streaming writes cannot be redirtied whilst under writeback,
    42                  * so discard the streaming record.
    43                  */
    44                 folio_detach_private(folio);
    45                 group = finfo->netfs_group;
    46                 gcount++;
    47                 kfree(finfo);
    48                 why = netfs_folio_trace_clear_s;
    49                 goto end_wb;
    50         }
    51 
    52         if ((group = netfs_folio_group(folio))) {
    53                 if (group == NETFS_FOLIO_COPY_TO_CACHE) {
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    54                         why = netfs_folio_trace_clear_cc;
--> 55                         if (group == NETFS_FOLIO_COPY_TO_CACHE)
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Duplicate check.  (This is an unpublished (too crappy) smatch check).

    56                                 folio_detach_private(folio);
    57                         else
    58                                 why = netfs_folio_trace_redirtied;
    59                         goto end_wb;
    60                 }
    61 
    62                 /* Need to detach the group pointer if the page didn't get
    63                  * redirtied.  If it has been redirtied, then it must be within
    64                  * the same group.
    65                  */
    66                 why = netfs_folio_trace_redirtied;
    67                 if (!folio_test_dirty(folio)) {
    68                         if (!folio_test_dirty(folio)) {
    69                                 folio_detach_private(folio);
    70                                 gcount++;
    71                                 why = netfs_folio_trace_clear_g;
    72                         }
    73                 }
    74         }
    75 
    76 end_wb:
    77         trace_netfs_folio(folio, why);
    78         folio_end_writeback(folio);
    79         return gcount;
    80 }

regards,
dan carpenter
